import 'package:flutter/material.dart';
import 'package:flutter_school/Screens/Authentication/authenticate.dart';
import 'package:flutter_school/Screens/Teacher/teacher_screen.dart';
import 'package:flutter_school/Screens/Welcome/components/background.dart';
import 'package:flutter_school/constants.dart';
import 'package:flutter_school/components/round_button.dart';

import '../../../widgets/app_large_text.dart';

// Body is a stateless widget that displays the welcome screen
class Body extends StatelessWidget {
  const Body({Key? key});

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // Prevent resizing when the keyboard appears
      resizeToAvoidBottomInset: false,
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Display the app title
              AppLargeText(text: 'Belize Preschool App'),
              SizedBox(height: size.height * 0.05),
              // Display the flag image
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  "assets/images/belize_flag.png",
                  width: size.width * 0.5,
                ),
              ),
              SizedBox(height: size.height * 0.05),
              // Display the teacher login button
              RoundButton(
                text: "Teacher",
                press: () async {
                  print("Building Teacher Login Screen");
                  Navigator.pushNamed(context, '/login');
                },
                color: myDarkBlue,
              ),
              // Display the parent login button
              RoundButton(
                text: "Parent",
                press: () async {
                  print("Building Parent Login Screen");
                  Navigator.pushNamed(context, '/login');
                },
                color: myDarkBlue,
              ),
              // Display the admin login button
              RoundButton(
                text: "Admin",
                press: () async {
                  print("Building Parent Login Screen");
                  Navigator.pushNamed(context, '/login');
                },
                color: myDarkBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Background is a stateless widget that displays a background with a child widget
class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // Display the top wave image
          Positioned(
            top: 0,
            left: 0,
            child: Visibility(
              visible: MediaQuery.of(context).viewInsets.bottom == 0,
              child: Image.asset(
                "assets/images/wave_blue_top.png",
                width: size.width,
              ),
            ),
          ),
          // Display the bottom wave image
          Positioned(
            bottom: 0,
            left: 0,
            child: Visibility(
              visible: MediaQuery.of(context).viewInsets.bottom == 0,
              child: Image.asset(
                "assets/images/wave_blue_bottom.png",
                width: size.width,
              ),
            ),
          ),
          // Display the child widget
          child,
        ],
      ),
    );
  }
}