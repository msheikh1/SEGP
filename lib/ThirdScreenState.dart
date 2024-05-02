import 'package:flutter/material.dart';
import 'package:flutter_school/Screens/admin/ListofTeachers.dart';
import 'package:flutter_school/Screens/admin/TeacherReport.dart';
import 'package:flutter_school/Screens/admin/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_school/Screens/admin/adminRegistration.dart';
import 'package:flutter_school/Screens/admin/listall.dart';
import 'package:flutter_school/Screens/admin/Lesson.dart';
import 'package:flutter_school/Screens/admin/classes.dart';
import 'package:flutter_school/Screens/admin/classesDetails.dart';
import 'package:flutter_school/Screens/admin/AddLessons.dart';
import 'package:flutter_school/Screens/admin/EditLessons.dart';
import 'package:flutter_school/models/class_structure.dart';
import 'package:flutter_school/constants.dart';
import 'package:flutter_school/Screens/admin/profile.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
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
            Icons.calendar_month_outlined,
            color: myCream,
          ),
          Icon(
            Icons.description, // Add this line for the report icon
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
        return RegistrationScreen(onStudentTap: (index) {
          updateIndex(index);
        });
      case 1:
        return TeachersListScreen(onStudentTap: (name, index) {
          updateIndex(index);
          updateData(name);
        });
      case 2:
        return TeachersAndStudentsScreen();
      case 3:
        return ClassesScreen(
            onStudentTap: (selectedMonth) => {
                  updateData(selectedMonth),
                  updateIndex(9),
                });
      case 4:
        return ProfileScreen(
          onStudentTap: (int) {
            updateIndex(int);
          },
        );
      case 5:
        return TeacherReportScreen(teacherName: data);
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
        return ClassesDetails(
          month: data,
          onStudentTap: (currentLesson, index) => {
            updateIndex(index),
            updateData3(currentLesson),
          },
          onAddTap: (month, index) => {updateData(month), updateIndex(index)},
          onBack: (index) => {updateIndex(index)},
        );
      case 10:
        return LessonScreen(
          lesson: data3,
          onBack: (index) => {
            updateIndex(index),
          },
        );
      case 11:
      case 12:
      default:
        return ProfileScreen(onStudentTap: (index) {
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

  void _updateData5(String string1, String string2) {
    setState(() {
      data5 = string1;
      data6 = string2;
    });
  }

  void _updatechild(String child) {
    child = child;
  }
}
