// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_school/Screens/Teacher/teacher_screen.dart';
import 'package:flutter_school/Screens/Welcome/components/background.dart';
import 'package:flutter_school/constants.dart';
import 'package:flutter_school/components/round_button.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
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
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TeacherScreen()),
              );
            },
          ),
          RoundButton(
            text: "Parent",
            press: () {},
            color: myPrimaryLightColor,
          ),
        ],
      ),
    ));
  }
}
