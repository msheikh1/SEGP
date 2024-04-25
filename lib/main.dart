import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_school/Screens/Parent/ChooseChild.dart';
import 'package:flutter_school/Screens/ThirdScreenState.dart';
import 'package:flutter_school/Screens/Welcome/LoginPage.dart';
import 'package:flutter_school/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_school/constants.dart';
import 'package:flutter_school/Screens/Teacher/teacher_screen.dart';
import 'package:flutter_school/Screens/Teacher/Lesson.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_school/Screens/MainScreenState.dart';
import 'package:flutter_school/Screens/SecondScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        '/teacher': (context) => MainScreen(),
        '/login': (context) => LoginPage(),
        '/parent': (context) => ChooseChildScreen(),
        '/admin': (context) => ThirdScreen()
      },
    );
  }
}
