import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/colors.dart';
import '../widgets/textfield_input.dart';

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


  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
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
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage('https://i.pinimg.com/474x/8f/1b/09/8f1b09269d8df868039a5f9db169a772.jpg'),
                        ),
                       Positioned(
                         bottom: -5,
                           left: 65,
                           child: IconButton( onPressed: () {}, icon: const Icon(Icons.add_a_photo,)))
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

                    //button login
                    SizedBox(height: 12,),

                    //login btn
                    InkWell(
                      child: Container(
                        child: Text('Sign Up'),
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
                          onTap: () {},
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
