import 'package:flutter/material.dart';
import 'package:flutter_school/Screens/EditStudent.dart';
import 'package:flutter_school/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_school/constants.dart';
import 'package:flutter_school/Screens/Teacher/teacher_screen.dart';
import 'package:flutter_school/Screens/Teacher/students.dart';
import 'package:flutter_school/Screens/Teacher/studentDetails.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MainScreen extends StatefulWidget {
  final List<String> initialData;

  const MainScreen({Key? key, required this.initialData}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 1;
  List<String> data = [];

  @override
  void initState() {
    super.initState();
    data = widget.initialData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScreen(currentIndex, _updateIndex, data, _updateData),
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

  Widget _buildScreen(int index, Function(int) updateIndex,
      List<String> initialData, Function(List<String>) updateData) {
    switch (index) {
      case 0:
        return StudentsScreen(
          onStudentTap: (newIndex) => updateIndex(newIndex),
        );
      case 3:
        return StudentDetails(
          Data: data,
          onStudentTap: (newIndex) => updateIndex(newIndex),
        );
      case 4:
        return EditStudentScreen(
          initialData: data,
          onEdit: (newData) => updateData(newData),
          onStudentTap: (newIndex) => updateIndex(newIndex),
        );
      default:
        return TeacherScreen();
    }
  }

  void _updateIndex(int newIndex) {
    setState(() {
      currentIndex = newIndex;
    });
  }

  void _updateData(List<String> newData) {
    setState(() {
      data = newData;
    });
  }
}
