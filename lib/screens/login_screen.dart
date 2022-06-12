import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/colors.dart';
import '../widgets/textfield_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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

               const SizedBox(height: 62),

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

           //button login
              SizedBox(height: 12,),

            //login btn
            InkWell(
              child: Container(
                child: Text('Log In'),
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
                            child: Text("Sign up now!", style: TextStyle(fontWeight: FontWeight.bold),),
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
