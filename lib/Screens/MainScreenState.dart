import 'package:flutter/material.dart';
import 'package:flutter_school/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_school/constants.dart';
import 'package:flutter_school/Screens/Teacher/teacher_screen.dart';
import 'package:flutter_school/Screens/Teacher/students.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScreen(currentIndex),
      bottomNavigationBar: CurvedNavigationBar(
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        backgroundColor: Colors.white,
        color: Colors.purple,
        items: [
          Icon(
            Icons.settings,
            color: Colors.white,
          ),
          Icon(
            Icons.home,
            color: Colors.white,
          ),
          Icon(
            Icons.favorite,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildScreen(int index) {
    switch (index) {
      case 0:
        return StudentsScreen();
      default:
        return TeacherScreen();

      // Add more cases for additional screens if needed
    }
  }
}
