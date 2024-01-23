import 'package:flutter/material.dart';
import 'package:flutter_school/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_school/constants.dart';
import 'package:flutter_school/Screens/Teacher/teacher_screen.dart';
import 'package:flutter_school/Screens/Teacher/students.dart';
import 'package:flutter_school/Screens/Teacher/studentDetails.dart';
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
      body: _buildScreen(currentIndex, _updateIndex),
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

  Widget _buildScreen(int index, Function(int) updateIndex) {
    switch (index) {
      case 0:
        return StudentsScreen(
            onStudentTap: (newIndex) => updateIndex(newIndex));
      case 3:
        return StudentDetails(
          onStudentTap: (newIndex) => updateIndex(newIndex),
        );
      default:
        return TeacherScreen();

      // Add more cases for additional screens if needed
    }
  }

  void _updateIndex(int newIndex) {
    setState(() {
      currentIndex = newIndex;
    });
  }
}
