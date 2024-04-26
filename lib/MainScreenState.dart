import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_school/Screens/EditStudent.dart';
import 'package:flutter_school/Screens/Parent/Lesson.dart';
import 'package:flutter_school/Screens/Teacher/MessageScreen.dart';
import 'package:flutter_school/Screens/Teacher/Milestones.dart';
import 'package:flutter_school/Screens/Teacher/add_task_bar.dart';
import 'package:flutter_school/Screens/Teacher/attendance.dart';
import 'package:flutter_school/Screens/Teacher/chat_page.dart';
import 'package:flutter_school/Screens/Teacher/classes.dart';
import 'package:flutter_school/Screens/Teacher/classesDetails.dart';
import 'package:flutter_school/Screens/Teacher/profile.dart';
import 'package:flutter_school/Screens/Teacher/teacher_screen.dart';
import 'package:flutter_school/Screens/Teacher/studentDetails.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_school/models/classStructure.dart';
import 'package:flutter_school/Screens/Teacher/Students.dart';
import 'package:flutter_school/Screens/Teacher/EditLessons.dart';
import 'package:flutter_school/Screens/Teacher/AddLessons.dart';
import 'package:flutter_school/constants.dart';
import 'package:flutter_school/Screens/Teacher/teacher_screen.dart';
import 'package:flutter_school/Screens/Teacher/Gallery.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 2;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScreen(currentIndex, _updateIndex, _updateData, _updateData2,
          _updateData3, _updateData4, _updateData5),
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

  Widget _buildScreen(
    int index,
    Function(int) updateIndex,
    Function(String) updateData,
    Function(List<Lesson>) updateData2,
    Function(Lesson) updateData3,
    Function(Student) updateData4,
    Function(String, String) updateData5,
  ) {
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
        return Students(
            data: data2,
            onStudentTap: (student) => {updateIndex(6), updateData4(student)});

      case 6:
        return StudentDetails(
            onStudentTap: (name, newIndex) =>
                {updateIndex(newIndex), _updateData(name)});
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
      case 9:
        return AddTaskPage();

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
        return AttendancePage(
          onStudentTap: (index) {
            updateIndex(index);
          },
        );
      default:
        return TeacherScreen(onStudentTap: (index) {
          updateIndex(index);
        });
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

  void _updateData5(String string1, String string2) {
    setState(() {
      data5 = string1;
      data6 = string2;
    });
  }
}
