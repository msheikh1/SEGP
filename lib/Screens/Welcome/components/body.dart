// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_school/Screens/Authetication/authenticate.dart';
import 'package:flutter_school/Screens/Teacher/teacher_screen.dart';
import 'package:flutter_school/Screens/Welcome/components/background.dart';
import 'package:flutter_school/constants.dart';
import 'package:flutter_school/components/round_button.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    Size size = MediaQuery.of(context).size;
    return Background(
        child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Preschool App",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: size.height * 0.05),
          Image.asset(
            "assets/images/schoolv3.png",
            width: size.width * 0.9,
          ),
          SizedBox(height: size.height * 0.05),
          RoundButton(
            text: "Teacher",
            press: () async {
              print("Building TeacherScreen");
              dynamic result = await _auth.signInAnon();

              Navigator.pushNamed(context, '/teacher');
            },
          ),
          RoundButton(
            text: "Parent",
            press: () async {
              dynamic result = await _auth.signInAnon();
              if (result == null) {
                print("error sign in");
              } else {
                print("success!");
                print(result);
              }
            },
            color: myPrimaryLightColor,
          ),
        ],
      ),
    ));
  }
}
