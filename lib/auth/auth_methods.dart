import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/auth/storage_methods.dart';
// import 'package:instagram_clone_flutter/models/user.dart' as model;
// import 'package:instagram_clone_flutter/resources/storage_methods.dart';

class AuthMethods {
  //creating firestore instance for firestore database
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //creating an auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get user details
  // Future<model.User> getUserDetails() async {
  //   User currentUser = _auth.currentUser!;
  //
  //   DocumentSnapshot documentSnapshot =
  //   await _firestore.collection('ig_users').doc(currentUser.uid).get();
  //
  //   return model.User.fromSnap(documentSnapshot);
  // }

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
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty || bio.isNotEmpty ) {
        // registering user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password,);


        //upload all the details to firestore database
        String photoUrl = await StorageMethods().uploadImageToStorage('profilePics', file, false);

        //to db
        _firestore.collection('ig-users').doc(cred.user!.uid).set({
           'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
          'photoURL': photoUrl,
        });
        res= "Success";


        // model.User _user = model.User(
        //   username: username,
        //   uid: cred.user!.uid,
        //   photoUrl: photoUrl,
        //   email: email,
        //   bio: bio,
        //   followers: [],
        //   following: [],
        // );

        // adding user in our database
        // await _firestore
        //     .collection("ig_users")
        //     .doc(cred.user!.uid)
        //     .set(_user.toJson());
        //
        // res = "Voila! Success!";


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