// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_school/Screens/Authentication/authenticate.dart';
import 'package:flutter_school/Screens/Teacher/teacher_screen.dart';
import 'package:flutter_school/Screens/Welcome/components/background.dart';
import 'package:flutter_school/constants.dart';
import 'package:flutter_school/components/round_button.dart';

class Body extends StatelessWidget {
  const Body({Key? key});

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    Size size = MediaQuery.of(context).size;
    return Background(

      child: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Align column at the start
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: size.height * 0.1), // Adjust this value according to your needs
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Preschool App",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: size.height * 0.05),
              RoundButton(
                text: "Teacher",
                press: () async {
                  print("Building TeacherScreen");
                  Navigator.pushNamed(context, '/login');
                },
                color: myDarkBlue,
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
                color: myDarkBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


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
        children: [
          Image.asset(
            "assets/images/belize_flag.png",
            width: size.width,
            height: size.height,
            fit: BoxFit.cover,
          ),
          child,
        ],
      ),
    );
  }
}
