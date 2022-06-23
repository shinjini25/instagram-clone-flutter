import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram_clone/methods/storage_methods.dart';
import 'package:instagram_clone/models/user.dart' as model;

import '../screens/login_screen.dart';
// import 'package:instagram_clone_flutter/resources/storage_methods.dart';

class AuthMethods {
  //creating firestore instance for firestore database
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //creating an methods instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get user details
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    String userUid = currentUser.uid;

    DocumentSnapshot snap =
        await _firestore.collection('ig-users').doc(userUid).get();

    return model.User.fromSnap(snap);
    // username= snap.get('username');
  }

  // Signing Up User
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    // profile photo
    required Uint8List file,
  }) async {
    String res = "Some error Occurred";
    try {
      // file != null
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        // registering user in methods with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        //upload all the details to firestore database
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        //to db
        model.User _user = model.User(
          username: username,
          uid: cred.user!.uid,
          photoUrl: photoUrl,
          email: email,
          bio: bio,
          followers: [],
          following: [],
        );
        await _firestore
            .collection('ig-users')
            .doc(cred.user!.uid)
            .set(_user.toJson());
        res = "success";
      } else {
        res = "Please enter all the fields first";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
