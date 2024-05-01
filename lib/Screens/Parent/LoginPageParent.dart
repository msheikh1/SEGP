import 'package:flutter/material.dart';
import 'package:flutter_school/Screens/Authentication/authenticate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_school/components/round_button.dart';
import 'package:flutter_school/components/text_field_container.dart';
import 'package:flutter_school/services/database.dart';
import 'package:flutter_school/widgets/app_large_text.dart';

import '../../components/rounded_input_field.dart';
import '../../components/rounded_password.dart';
import '../../constants.dart';

class LoginPageParent extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPageParent> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthService _auth = AuthService();
  final DatabaseService _databaseService = DatabaseService();

  void _signInWithEmailAndPassword() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text;

    final User? user = await _auth.signInWithEmailAndPassword(email, password);

    if (user != null) {
      // Navigate to home screen or do something else
      // Navigate to home screen or do something else
      print('User logged in: ${user.email}');
      String? Type = await _databaseService.getUserType(user);
      print("Type value:" + Type!);
      String currentType = "";
      if (Type != null) {
        currentType = Type;
      }
      print("Login Type: " + currentType);
      if (currentType == "teacher") {
        Navigator.pushNamed(context, '/teacher');
      } else {
        if (currentType == "parent") {
          Navigator.pushNamed(context, '/parent');
        } else {
          Navigator.pushNamed(context, '/admin');
        }
      }
    } else {
      // Show error message or handle sign-in failure
      print('Failed to sign in');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Title"),
      ),
      body: Container(
        height: size.height,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 40),
                    AppLargeText(text: 'Login'),
                    SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        "assets/images/tapir_nobg.png",
                        width: size.width * 0.5,
                      ),
                    ),
                    SizedBox(height: 60),
                    RoundedInputField(
                      emailController: _emailController,
                      hintText: ('Your Email'),
                      onChanged: (String value) {},
                    ),
                    RoundedPasswordField(
                      onChanged: (String value) {},
                      passwordController: _passwordController,
                    ),
                    RoundButton(
                      text: ("Login"),
                      press: _signInWithEmailAndPassword,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Don't have an Account? ",
                          style: TextStyle(color: myDarkBlue),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/registerParent');
                          },
                          child: const Text(
                            "Register",
                            style: TextStyle(
                              color: myDarkBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20), // Add some space at the bottom
                  ],
                ),
              ),
            ),
            // Positioned to overlay at the bottom of the screen
            // Positioned(
            //   bottom: 0,
            //   left: 0,
            //   right: 0,
            //   child: Image.asset(
            //     "assets/images/wave_blue_bottom.png",
            //     width: size.width * 0.2,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
