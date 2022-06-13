
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class  MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  String username = "";

  @override
  void initState() {
    super.initState();
   getUserName();
  }

  void getUserName() async {
    String userUid=  FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot snap = await FirebaseFirestore.instance.collection('ig-users').doc(userUid).get();

   // print(snap.data());

   setState(() {
     username= snap.get('username');

   });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text('$username'),
    ),
    );
  }
}
