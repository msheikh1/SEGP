import 'package:flutter/material.dart';
import 'package:flutter_school/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_school/constants.dart';
import 'package:flutter_school/Screens/Teacher/teacher_screen.dart';
import 'package:flutter_school/Screens/Teacher/students.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_school/Screens/MainScreenState.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter School',
      theme: ThemeData(
        primaryColor: myPrimaryColor,
        scaffoldBackgroundColor: myBackgroundColor,
      ),
      home: const WelcomeScreen(),
      routes: {
        '/teacher': (context) => MainScreen(
              initialData: ["John Doe", "2", "Math,Science"],
            ),
      },
    );
  }
}
