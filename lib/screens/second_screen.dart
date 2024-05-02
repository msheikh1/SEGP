// Import necessary packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_school/Screens/Parent/message_screen.dart';
import 'package:flutter_school/Screens/Parent/chat_page.dart';
import 'package:flutter_school/Screens/Parent/profile.dart';
import 'package:flutter_school/Screens/Parent/teacher_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_school/models/class_structure.dart';
import 'package:flutter_school/constants.dart';
import 'package:flutter_school/Screens/Parent/lesson.dart';
import 'package:flutter_school/Screens/Parent/classes.dart';
import 'package:flutter_school/Screens/Parent/classes_details.dart';

// SecondScreen is a stateful widget that displays the second screen
class SecondScreen extends StatefulWidget {
  // child is a required parameter that contains the child's name
  final String child;

  // Constructor
  const SecondScreen({Key? key, required this.child}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  // currentIndex is the index of the current screen
  int currentIndex = 2;
  // data, data2, data3, data5, and data6 are variables to hold various types of data
  String data = "";
  List<Lesson> data2 = [];
  late Lesson data3;
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
          _updateData3, _updateData5, _updatechild),
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

  // Function to build the screen based on the current index
  Widget _buildScreen(
    int index,
    Function(int) updateIndex,
    Function(String) updateData,
    Function(List<Lesson>) updateData2,
    Function(Lesson) updateData3,
    Function(String, String) updateData5,
    Function(String) updatechild,
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
        return ProfileScreen(onStudentTap: (index) {
          updateIndex(index);
        }, onChangeChild: (data) {
          updatechild(data);
          updateIndex(2);
        });
      case 2:
        return TeacherScreen(
          onStudentTap: (index) {
            updateIndex(index);
          },
          child: widget.child,
        );

      case 3:
      case 4:
        return ClassesScreen(
            onStudentTap: (selectedMonth) => {
                  updateData(selectedMonth),
                  updateIndex(12),
                });

      // return EditStudentScreen(
      //  onEdit: (newData) => updateData(newData),
      //  onStudentTap: (newIndex) => updateIndex(newIndex),
      //  );

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
          child: widget.child,
          onStudentTap: (currentLesson, index) => {
            updateIndex(index),
            updateData3(currentLesson),
          },
          onAddTap: (month, index) => {updateData(month), updateIndex(index)},
          onBack: (index) => {updateIndex(index)},
        );
      default:
        return TeacherScreen(
          onStudentTap: (index) {
            updateIndex(index);
          },
          child: widget.child,
        );
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

  // Function to update the data5 and data6
  void _updateData5(String string1, String string2) {
    setState(() {
      data5 = string1;
      data6 = string2;
    });
  }

  // Function to update the child
  void _updatechild(String child) {
    child = child;
  }
}