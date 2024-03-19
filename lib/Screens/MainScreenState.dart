import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_school/Screens/EditStudent.dart';
import 'package:flutter_school/Screens/Teacher/classes.dart';
import 'package:flutter_school/Screens/Teacher/classesDetails.dart';
import 'package:flutter_school/Screens/Teacher/teacher_screen.dart';
import 'package:flutter_school/Screens/Teacher/Lesson.dart';
import 'package:flutter_school/Screens/Teacher/studentDetails.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_school/models/classStructure.dart';
import 'package:flutter_school/Screens/Teacher/Students.dart';
import 'package:flutter_school/Screens/Teacher/EditLessons.dart';
import 'package:flutter_school/Screens/Teacher/AddLessons.dart';
import 'package:flutter_school/constants.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 1;
  String data = "";
  List<Lesson> data2 = [];
  late Lesson data3;
  late Student data4;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScreen(currentIndex, _updateIndex, _updateData, _updateData2,
          _updateData3, _updateData4),
      bottomNavigationBar: CurvedNavigationBar(
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        backgroundColor: myBackgroundColor,
        color: myDarkBlue,
        items: [
          Icon(
            Icons.favorite,
            color: myCream,
          ),
          Icon(
            Icons.calendar_month_outlined,
            color: myCream,
          ),
          Icon(
            Icons.home,
            color: myCream,
          ),
          Icon(
            Icons.analytics_outlined,
            color: myCream,
          ),
          Icon(
            Icons.settings,
            color: myCream,
          ),
        ],
      ),
    );
  }

  Widget _buildScreen(
    int index,
    Function(int) updateIndex,
    Function(String) updateData,
    Function(List<Lesson>) updateData2,
    Function(Lesson) updateData3,
    Function(Student) updateData4,
  ) {
    switch (index) {
      case 0:
        return ClassesScreen(
            onStudentTap: (selectedMonth) => {
                  updateData(selectedMonth),
                  updateIndex(3),
                });
      case 2:
        return TeacherScreen();

      case 3:
        return ClassesDetails(
          month: data,
          onStudentTap: (currentLesson, index) => {
            updateIndex(index),
            updateData3(currentLesson),
          },
          onAddTap: (month, index) => {updateData(month), updateIndex(index)},
          onBack: (index) => {updateIndex(index)},
        );

      case 4:
        return LessonScreen(
            lesson: data3, onBack: (index) => {updateIndex(index)});
      case 5:
        return Students(
            data: data2,
            onStudentTap: (student) => {updateIndex(6), updateData4(student)});

      case 6:
        return StudentDetails(
          data: data4,
          onStudentTap: (newIndex) => updateIndex(newIndex),
        );
      case 7:
        return AddLesson(
          month: data,
          onStudentTap: (index) => updateIndex(index),
        );
      // return EditStudentScreen(
      //  onEdit: (newData) => updateData(newData),
      //  onStudentTap: (newIndex) => updateIndex(newIndex),
      //  );
      case 8:
        return EditLessonScreen(
          lesson: data3,
          onBack: (index) => {updateIndex(index)},
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

  void _updateData(String newData) {
    setState(() {
      data = newData;
    });
  }

  void _updateData2(List<Lesson> newData) {
    setState(() {
      data2 = newData;
    });
  }

  void _updateData3(Lesson newData) {
    setState(() {
      data3 = newData;
    });
  }

  void _updateData4(Student newData) {
    setState(() {
      data4 = newData;
    });
  }
}
