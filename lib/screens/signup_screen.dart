// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/methods/auth_methods.dart';
import 'package:instagram_clone/utils/select_img.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/colors.dart';
import '../utils/global_variables.dart';
import '../utils/snackbar.dart';
import '../widgets/textfield_input.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;

  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

//select an image function
  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        file: _image!);

    if (res != "success") {
      // show the error
      showSnackBar(context, res);
    } else {
      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(
      //       builder: (context) => const ResponsiveLayout(
      //         mobileScreenLayout: MobileScreenLayout(),
      //         webScreenLayout: WebScreenLayout(),
      //       ),
      //     ),
      //     (route) => false);
      setState(() {
        _isLoading = false;
      });
      showSnackBar(context, res);
      navigateToLogin();
    }
  }

  void navigateToLogin() async {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                padding: MediaQuery.of(context).size.width > webScreenSize
                    ? EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 3)
                    : EdgeInsets.symmetric(horizontal: 32),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //logo, app name, text fields and login button, transition to sign up
                    Flexible(child: Container(), flex: 2),
                    //logo
                    SvgPicture.asset('assets/ig_logo.svg',
                        color: primaryColor, height: 60),

                    const SizedBox(height: 15),
                    //circular widget input for accepting profile avatars
                    Stack(
                      children: [
                        _image != null
                            ? CircleAvatar(
                                radius: 50,
                                backgroundImage: MemoryImage(_image!),
                              )
                            : const CircleAvatar(
                                radius: 45,
                                backgroundImage: NetworkImage(
                                    'https://i.stack.imgur.com/l60Hf.png'),
                              ),
                        Positioned(
                            bottom: 5,
                            left: 40,
                            child: IconButton(
                                onPressed: selectImage,
                                icon: const Icon(
                                  // Icons.add_photo_alternate_rounded,
                                  Icons.add_outlined,
                                  color: Colors.black,
                                  size: 45,
                                )))
                      ],
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    const SizedBox(
                      child: Center(
                        child: Text(
                            "Click on the add icon button above to add your profile picture",
                            style: TextStyle(color: Colors.grey, fontSize: 13)),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),

                    //text field input for username
                    SizedBox(
                      height: 37,
                      child: TextFieldInput(
                        hintText: 'Enter your Username',
                        textInputType: TextInputType.text,
                        textEditingController: _usernameController,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    //email field input
                    SizedBox(
                      height: 37,
                      child: TextFieldInput(
                        hintText: 'Enter your Email',
                        textInputType: TextInputType.emailAddress,
                        textEditingController: _emailController,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    //pass
                    SizedBox(
                      height: 37,
                      child: TextFieldInput(
                        hintText: 'Enter your Password',
                        textInputType: TextInputType.text,
                        textEditingController: _passwordController,
                        isPass: true,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //bio
                    SizedBox(
                      height: 37,
                      child: TextFieldInput(
                        hintText: 'Enter a short Bio..',
                        textInputType: TextInputType.text,
                        textEditingController: _bioController,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    // SizedBox(height: 12,),

                    //login btn
                    InkWell(
                      onTap: signUpUser,
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 17),
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          color: blueColor,
                        ),
                        child: _isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                    color: primaryColor))
                            : const Text('Sign Up'),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),

                    //transition to signup
                    Flexible(
                      child: Container(),
                      flex: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: navigateToLogin,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(children: const [
                              Icon(Icons.arrow_back_ios_new,
                                  color: Colors.white),
                              Text(
                                "Back to Login Page",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ],
                ))));
  }
}
