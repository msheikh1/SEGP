import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_school/Screens/Parent/MessageScreen.dart';
import 'package:flutter_school/Screens/Parent/attendanceparent.dart';
import 'package:flutter_school/Screens/Parent/chat_page.dart';
import 'package:flutter_school/Screens/Parent/profile.dart';
import 'package:flutter_school/Screens/Parent/teacher_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_school/models/classStructure.dart';
import 'package:flutter_school/constants.dart';
import 'package:flutter_school/Screens/Parent/Lesson.dart';
import 'package:flutter_school/Screens/Parent/classes.dart';
import 'package:flutter_school/Screens/Parent/classesDetails.dart';

class SecondScreen extends StatefulWidget {
  final String child;
  const SecondScreen({Key? key, required this.child}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  int currentIndex = 2;
  String data = "";
  List<Lesson> data2 = [];
  late Lesson data3;
  String data5 = "";
  String data6 = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScreen(currentIndex, _updateIndex, _updateData, _updateData2,
          _updateData3, _updateData5, _updatechild),
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
    Function(String, String) updateData5,
    Function(String) updatechild,
  ) {
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
        return StudentAttendance(studentName: widget.child);

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

  void _updateData5(String string1, String string2) {
    setState(() {
      data5 = string1;
      data6 = string2;
    });
  }

  void _updatechild(String child) {
    setState(() {
      child = child;
    });
  }
}
