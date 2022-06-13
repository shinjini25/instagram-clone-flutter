import 'dart:typed_data';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/auth/auth_methods.dart';
import 'package:instagram_clone/utils/select_img.dart';
import '../utils/colors.dart';
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
   Uint8List img=  await pickImage(ImageSource.gallery);
   setState(() {
     _image = img;
   });
  }

  void signUpUser() async {
    setState(() {
      _isLoading= true;
    });
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        file: _image!);

    if (res !="success") {
      // show the error
      showSnackBar(context, res);
    }
    else{
      setState(() {
        _isLoading= false;
      });
    }
  }
  void navigateToLogin() async {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen() ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 32),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    //logo, app name, text fields and login button, transition to sign up
                    Flexible( child: Container(), flex: 2),
                    //logo
                    SvgPicture.asset('assets/ig_logo.svg', color: primaryColor, height: 60),

                    const SizedBox(height: 15),
                    //circular widget input for accepting profile avatars
                    Stack(
                      children: [
                        _image != null ? CircleAvatar( radius: 50, backgroundImage: MemoryImage(_image!), ) : const CircleAvatar( radius: 64, backgroundImage: NetworkImage('https://i.stack.imgur.com/l60Hf.png'),),
                       Positioned(
                         bottom: -5,
                           left: 65,
                           child: IconButton( onPressed: selectImage, icon: const Icon(Icons.add_a_photo, color: Colors.black,)))
                      ],
                    ),

                    SizedBox(height: 15,),
                    //text field input for username
                    TextFieldInput(
                      hintText: 'Enter your Username',
                      textInputType: TextInputType.text,
                      textEditingController: _usernameController ,
                    ),
                    SizedBox(height: 13,),

                    //email field input
                    TextFieldInput(
                      hintText: 'Enter your Email',
                      textInputType: TextInputType.emailAddress,
                      textEditingController: _emailController ,
                    ),
                    SizedBox(height: 13,),

                    //pass
                    TextFieldInput(
                      hintText: 'Enter your Password',
                      textInputType: TextInputType.text,
                      textEditingController: _passwordController ,
                      isPass: true,
                    ),
                    SizedBox(height: 13,),
                    //bio
                    TextFieldInput(
                      hintText: 'Enter a short Bio..',
                      textInputType: TextInputType.text,
                      textEditingController: _bioController ,
                    ),
                    SizedBox(height: 13,),

                    // SizedBox(height: 12,),

                    //login btn
                    InkWell(
                      onTap: signUpUser,
                      child: Container(
                        child: _isLoading ?
                        const Center(child: CircularProgressIndicator(color: primaryColor))
                            : Text('Sign Up'),
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 17),
                        decoration: const ShapeDecoration(shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                          color:blueColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 12,),

                    //transition to signup
                    Flexible(child: Container(), flex: 1,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text("Don't have an account?"),
                          // padding: EdgeInsets.symmetric(vertical: 10),
                        ),
                        SizedBox(width: 10,),
                        GestureDetector(
                          onTap: navigateToLogin,
                          child: Container(
                            // child: Text("Sign up now!", style: TextStyle(fontWeight: FontWeight.bold),),
                            // padding: EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),

                      ],
                    ),
                  ],
                )
            )
        )
    );
  }
}
