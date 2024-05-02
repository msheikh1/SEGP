// Import necessary packages
import 'package:flutter/material.dart';
import 'package:flutter_school/Screens/admin/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_school/Screens/admin/adminRegistration.dart';
import 'package:flutter_school/Screens/admin/listall.dart';
import 'package:flutter_school/models/classStructure.dart';
import 'package:flutter_school/constants.dart';

// ThirdScreen is a stateful widget that displays the third screen
class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
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
        return RegistrationScreen();
      case 1:
        return ProfileScreen(onStudentTap: (index) {
          updateIndex(index);
        }, onChangeChild: (data) {
          updatechild(data);
          updateIndex(2);
        });
      case 2:
        return TeachersAndStudentsScreen();
      case 3:
      case 4:
      case 10:
      case 11:
      case 12:
      default:
        return ProfileScreen(onStudentTap: (index) {
          updateIndex(index);
        }, onChangeChild: (data) {
          updatechild(data);
          updateIndex(2);
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