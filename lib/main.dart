import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/screens/signup_screen.dart';

import 'package:instagram_clone/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialise app based on platform- web or mobile
  if (kIsWeb) {
    //config for web
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCU22DWc7IbRICmPO6ndHHitjpNdRw6us8",
          projectId: "flutter-instagram-clone-32dee",
          storageBucket: "flutter-instagram-clone-32dee.appspot.com",
          messagingSenderId: "653486519476",
          appId: "1:653486519476:web:d69b140b99993e86ea93e1"),
    );
  } else {
    //for mobile
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCU22DWc7IbRICmPO6ndHHitjpNdRw6us8",
          appId: "1:653486519476:android:1e9a5f5423fb41c9ea93e1",
          messagingSenderId: "653486519476",
          projectId: "flutter-instagram-clone-32dee",
          storageBucket: 'flutter-instagram-clone-32dee.firebaseapp.com'),
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Instagram clone',
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        // home: LoginScreen(),
        // );

        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              // Checking if the snapshot has any data or not
              if (snapshot.hasData) {
                // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }

            // means connection to future hasn't been made yet
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
