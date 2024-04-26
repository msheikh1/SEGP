import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_school/Screens/Teacher/add_task_bar.dart';
import 'package:flutter_school/constants.dart';
import 'package:flutter_school/main.dart';
import 'package:flutter_school/models/classStructure.dart';
import 'package:flutter_school/services/database.dart';
import 'package:flutter_school/widgets/app_large_text.dart';
import 'package:flutter_school/widgets/app_text.dart';
import 'package:flutter_school/widgets/button.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_school/Screens/Authentication/authenticate.dart';

class TeacherScreen extends StatefulWidget {
  final Function(int) onStudentTap;

  const TeacherScreen({Key? key, required this.onStudentTap}) : super(key: key);

  @override
  TeacherScreenState createState() => TeacherScreenState();
}
final titleController = TextEditingController();
final descriptionController = TextEditingController();

class TeacherScreenState extends State<TeacherScreen> {
  DateTime _selectedDate = DateTime.now();
  DatabaseService database = DatabaseService();
  AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _topNavigationBar(),
        SizedBox(
          height: 40,
        ),
        FutureBuilder<Widget>(
          future: _topHeadingBar(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show a loading indicator while waiting for the future to complete
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // Show an error message if the future encounters an error
              return Text('Error: ${snapshot.error}');
            } else {
              // Show the widget returned by the future
              return snapshot.data!;
            }
          },
        ),
        SizedBox(
          height: 20,
        ),
        _addTaskBar(),
        SizedBox(
          height: 20,
        ),
        _addDateBar(),
        SizedBox(
          height: 20,
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 25,
          ),
          width: double.infinity,
          height: 160,
          decoration: BoxDecoration(
            color: myCream,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 12, top: 12, right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row( // Modified to use a Row widget
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Title Text",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Date Time Text",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Divider(thickness: 2,),
                SizedBox(height: 5),
                Text(
                  "Description Text",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(), // Adjusted padding
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.image_outlined),
                        iconSize: 30,
                        onPressed: () => Navigator.pushNamed(context, '/gallery'),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        iconSize: 30,
                        onPressed: () {
                          // Add delete functionality here
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        ],
    ));
  }

  _addDateBar() {
    final DateTime now = DateTime.now();
    final DateTime earliestDate = DateTime(now.year - 2, now.month, now.day);

    return Container(
      margin: const EdgeInsets.only(left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: myDarkBlue,
        selectedTextColor: myCream,
        dateTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        dayTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        monthTextStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        onDateChange: (date) {
          setState(() {
            _selectedDate = date; // Update the selected date
          });
        },
      ),
    );
  }


  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppLargeText(
                    text: DateFormat.yMMMMd().format(DateTime.now()), size: 20),
                AppText(text: 'Today', size: 20)
              ],
            ),
          ),
          MyButton(
              label: "+ Add activity",
              onTap: () => { Navigator.pushNamed(context, '/activity')}),
        ],
      ),
    );
  }

  _topNavigationBar() {
    return Container(
        padding: const EdgeInsets.only(top: 50, left: 20),
        child: Row(
          children: [
            Icon(Icons.menu, size: 30, color: Colors.black54),
            Expanded(child: Container()),
            Container(
              margin: const EdgeInsets.only(right: 20),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.5),
              ),
            )
          ],
        ));
  }

  Future<Widget> _topHeadingBar() async {
    final User? user = _auth.getCurrentUser();
    String name = "Unknown User"; // Default value

    if (user != null) {
      name = await database.getUserName(user) ?? name;
    }

    return Container(
      margin: const EdgeInsets.only(left: 20),
      child: AppLargeText(text: "Welcome Teacher $name"),
    );
  }

}
