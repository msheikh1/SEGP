import 'package:flutter/material.dart';
import 'package:flutter_school/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_school/constants.dart';

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
    );
  }
}
