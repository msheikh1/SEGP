// Import necessary packages
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_school/Screens/Parent/choose_child.dart';
import 'package:flutter_school/Screens/Parent/login_page_parent.dart';
import 'package:flutter_school/Screens/Teacher/attendance.dart';
import 'package:flutter_school/Screens/Welcome/login_page.dart';
import 'package:flutter_school/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_school/third_screen_state.dart';
import 'package:flutter_school/constants.dart';
import 'package:flutter_school/Screens/Teacher/teacher_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_school/main_screen_state.dart';

import 'Screens/Teacher/gallery.dart';

// Main function
void main() async {
  // Ensure that Firebase is initialized
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey:
            'AIzaSyDxHlkvaTcbuNYT8kxrl66qEYvX7QyQOZs', // paste your api key here
        appId:
            "1:676593102268:android:2df513a22fca64fd418fb9", //paste your app id here
        messagingSenderId: '676593102268', //paste your messagingSenderId here
        projectId: 'segpgrp-j', //paste your project id here
        storageBucket: 'segpgrp-j.appspot.com'),
  );
  // Run the app
  runApp(const MyApp());
}

// MyApp is a stateless widget that represents the entire application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
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
          '/parentLogin': (context) => LoginPageParent(),
          '/admin': (context) => ThirdScreen(),
          '/gallery': (context) => Gallery(),
        },
      ),
    );
  }
}