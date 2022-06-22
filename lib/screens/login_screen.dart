import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/screens/signup_screen.dart';
import 'package:instagram_clone/utils/global_variables.dart';
import '../methods/auth_methods.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/colors.dart';
import '../utils/snackbar.dart';
import '../widgets/textfield_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == "success") {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            ),
          ),
          (route) => false);

      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(context, res);
    }
  }

  void navigateToSignUp() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignupScreen()));
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

                    const SizedBox(height: 62),

                    //email field input
                    TextFieldInput(
                      hintText: 'Enter your Email',
                      textInputType: TextInputType.emailAddress,
                      textEditingController: _emailController,
                    ),
                    SizedBox(
                      height: 13,
                    ),

                    //pass
                    TextFieldInput(
                      hintText: 'Enter your Password',
                      textInputType: TextInputType.text,
                      textEditingController: _passwordController,
                      isPass: true,
                    ),

                    //button login
                    SizedBox(
                      height: 12,
                    ),

                    //login btn
                    InkWell(
                      onTap: loginUser,
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
                        child: !_isLoading
                            ? const Text(
                                'Log in',
                              )
                            : const CircularProgressIndicator(
                                color: primaryColor,
                              ),
                      ),
                    ),
                    SizedBox(
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
                        Container(
                          padding: EdgeInsets.only(
                            bottom: 10,
                          ),
                          child: Text("Don't have an account?"),
                          // padding: EdgeInsets.symmetric(vertical: 10),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: navigateToSignUp,
                          child: Container(
                            padding: EdgeInsets.only(
                              bottom: 10,
                            ),
                            child: Text(
                              "Sign up now!",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            // padding: EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                      ],
                    ),
                  ],
                ))));
  }
}
