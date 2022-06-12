import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/screens/signup_screen.dart';

import 'package:instagram_clone/utils/colors.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialise app based on platform- web or mobile
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCU22DWc7IbRICmPO6ndHHitjpNdRw6us",
          appId: "1:653486519476:web:d69b140b99993e86ea93e1",
          messagingSenderId: "653486519476",
          projectId: "flutter-instagram-clone-32dee",
          storageBucket: 'flutter-instagram-clone-32dee.firebaseapp.com'
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Instagram clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor
      ),
  home: SignupScreen(),
  // home: ResponsiveLayout( mobileScreenLayout: MobileScreenLayout(), webScreenLayout: WebScreenLayout (),),
    );
  }
}


