// Import necessary packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_school/Screens/edit_student.dart';
import 'package:flutter_school/Screens/Teacher/message_screen.dart';
import 'package:flutter_school/Screens/Teacher/milestones.dart';
import 'package:flutter_school/Screens/Teacher/add_task_bar.dart';
import 'package:flutter_school/Screens/Teacher/chat_page.dart';
import 'package:flutter_school/Screens/Teacher/classes.dart';
import 'package:flutter_school/Screens/Teacher/classes_details.dart';
import 'package:flutter_school/Screens/Teacher/profile.dart';
import 'package:flutter_school/Screens/Teacher/teacher_screen.dart';
import 'package:flutter_school/Screens/Teacher/Lesson.dart';
import 'package:flutter_school/Screens/Teacher/student_details.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_school/models/class_structure.dart';
import 'package:flutter_school/Screens/Teacher/Students.dart';
import 'package:flutter_school/constants.dart';
import 'package:flutter_school/Screens/Teacher/teacher_screen.dart';
import 'package:flutter_school/Screens/Teacher/gallery.dart';

// MainScreen is a stateful widget that displays the main screen
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // currentIndex is the index of the current screen
  int currentIndex = 2;
  // data, data2, data3, data4, data5, and data6 are variables to hold various types of data
  String data = "";
  List<Lesson> data2 = [];
  late Lesson data3;
  late Student data4;
  String data5 = "";
  String data6 = "";

  @override
  void initState() {
    super.initState();
  }

  // Build method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The body of the scaffold is determined by the _buildScreen function
      body: _buildScreen(currentIndex, _updateIndex, _updateData, _updateData2,
          _updateData3, _updateData4, _updateData5),
      // The bottom navigation bar is a CurvedNavigationBar
      bottomNavigationBar: CurvedNavigationBar(
        index: 2,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        backgroundColor: myBackgroundColor,
        color: myDarkBlue,
        items: [
          Icon(
            Icons.message,
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
            Icons.add_box_outlined,
            color: myCream,
          ),
          Icon(
            Icons.person_outline_rounded,
            color: myCream,
          ),
        ],
      ),
    );
  }

  // Function to build the screen based on the current index
  Widget _buildScreen(
    int index,
    Function(int) updateIndex,
    Function(String) updateData,
    Function(List<Lesson>) updateData2,
    Function(Lesson) updateData3,
    Function(Student) updateData4,
    Function(String, String) updateData5,
  ) {
    // The screen to display is determined by the current index
    switch (index) {
      case 0:
        return MessageScreen(
            onStudentTap: (string1, string2, index) => {
                  updateData5(string1, string2),
                  updateIndex(index),
                });
      case 1:
        return ClassesScreen(
            onStudentTap: (selectedMonth) => {
                  updateData(selectedMonth),
                  updateIndex(12),
                });
      case 2:
        return TeacherScreen(onStudentTap: (index) {
          updateIndex(index);
        });

      case 3:
        return Milestones(onStudentTap: (index) {
          updateIndex(index);
        });
      case 4:
        return ProfileScreen(onStudentTap: (index) {
          updateIndex(index);
        });
      case 5:
      case 6:
      case 9:
        return StudentDetails(
            onStudentTap: (name, newIndex) =>
                {updateIndex(newIndex), _updateData(name)});
      case 10:
        return LessonScreen(
          lesson: data3,
          onBack: (index) => {
            updateIndex(index),
          },
        );
      case 11:
        return ChatPage(receiverName: data5, receiverID: data6);
      case 12:
        return ClassesDetails(
          month: data,
          onStudentTap: (currentLesson, index) => {
            updateIndex(index),
            updateData3(currentLesson),
          },
          onAddTap: (month, index) => {updateData(month), updateIndex(index)},
          onBack: (index) => {updateIndex(index)},
        );
      case 13:
      default:
        return TeacherScreen(onStudentTap: (index) {
          updateIndex(index);
        });
    }
  }

  // Function to update the current index
  void _updateIndex(int newIndex) {
    setState(() {
      currentIndex = newIndex;
    });
  }

  // Function to update the data
  void _updateData(String newData) {
    setState(() {
      data = newData;
    });
  }

  // Function to update the data2
  void _updateData2(List<Lesson> newData) {
    setState(() {
      data2 = newData;
    });
  }

  // Function to update the data3
  void _updateData3(Lesson newData) {
    setState(() {
      data3 = newData;
    });
  }

  // Function to update the data4
  void _updateData4(Student newData) {
    setState(() {
      data4 = newData;
    });
  }

  // Function to update the data5 and data6
  void _updateData5(String string1, String string2) {
    setState(() {
      data5 = string1;
      data6 = string2;
    });
  }
}