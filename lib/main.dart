import 'package:flutter/material.dart';
import 'package:flutter_school/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_school/constants.dart';
import 'package:flutter_school/Screens/Teacher/teacher_screen.dart';
import 'package:flutter_school/Screens/Teacher/students.dart';
import 'package:provider/provider.dart';

void main() {
  ChangeNotifierProvider(
    create: (context) => NavigationState(),
    child: const MyApp(),
  );
}

class NavigationState with ChangeNotifier {
  int selectedIndex = 0;

  void setIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
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
        '/teacher': (context) => TeacherScreen(),
        '/students': (context) => StudentsScreen(),
      },
    );
  }
}
