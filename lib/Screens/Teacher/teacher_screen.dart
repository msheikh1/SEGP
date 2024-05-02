import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_school/Screens/Teacher/add_task_bar.dart';
import 'package:flutter_school/constants.dart';
import 'package:flutter_school/main.dart';
import 'package:flutter_school/models/class_structure.dart';
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
        _returnLessons(),
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
              label: "+ View Students",
              onTap: () => widget.onStudentTap(6)),
        ],
      ),
    );
  }

  Widget _topNavigationBar() {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 20),
      child: Row(
        children: [
          Icon(Icons.menu, size: 30, color: Colors.black54),
          Expanded(child: Container()),
          IconButton(
            onPressed: () {
              // Call your function here
              // For example:
              widget.onStudentTap(13);
            },
            icon: Icon(Icons.assignment, size: 30, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _returnLessons() {
    return Expanded(
      child: FutureBuilder(
          future: database.getSelectLessons(_selectedDate),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return StreamBuilder(
                stream: snapshot.data as Stream<QuerySnapshot>,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    var temp = snapshot.data!.docs
                        .length; // Here you can access the value of the future
                    print("Lessons: $temp");
                    List lessons = snapshot.data?.docs ?? [];
                    int counter = 0; // Initialize counter here
                    for (var lessonDocument in lessons) {
                      Lesson lesson = lessonDocument.data();
                      counter++;
                      return ListView.builder(
                        itemCount: lessons.length,
                        itemBuilder: (context, index) {
                          Lesson lesson = lessons[index].data();
                          return ListTile(
                            title: Text(lesson.name),
                            subtitle: Text(lesson.details),
                            trailing: lesson.completed
                                ? Icon(Icons.check_circle)
                                : Icon(Icons.radio_button_unchecked),
                          );
                        },
                      );
                    }
                    if (counter == 0) {
                      return Center(
                        child: Text("No Lessons"),
                      );
                    }
                    return SizedBox
                        .shrink(); // Return an empty widget if lessons are found for the month
                  }
                },
              );
            }
          }),
    );
  }

  // Widget _returnLessons() {
  //   return Expanded(
  //     child: ListView.builder(
  //       itemCount: teachers.length,
  //       itemBuilder: (context, index) {
  //         return FutureBuilder<Stream<QuerySnapshot<Lesson>>>(
  //           future: database.getLessonsForTeachersForDaily(
  //               teachers[index], _selectedDate),
  //           builder: (context, snapshot) {
  //             if (snapshot.connectionState == ConnectionState.waiting) {
  //               return Center(
  //                 child: CircularProgressIndicator(),
  //               );
  //             } else if (snapshot.hasError) {
  //               return Text('Error: ${snapshot.error}');
  //             } else {
  //               final stream = snapshot.data;
  //               if (stream == null) {
  //                 return Center(
  //                   child: Text("No Lessons"),
  //                 );
  //               }
  //               return StreamBuilder<QuerySnapshot<Lesson>>(
  //                 stream: stream,
  //                 builder: (context, snapshot) {
  //                   if (snapshot.connectionState == ConnectionState.waiting) {
  //                     return Center(
  //                       child: CircularProgressIndicator(),
  //                     );
  //                   } else if (snapshot.hasError) {
  //                     return Text('Error: ${snapshot.error}');
  //                   } else {
  //                     final List<Lesson> lessons = snapshot.data?.docs
  //                         .map((doc) => doc.data())
  //                         .toList() ??
  //                         [];
  //                     if (lessons.isEmpty) {
  //                       return Center(
  //                         child: Text("No Lessons"),
  //                       );
  //                     }
  //                     return ListView.builder(
  //                       shrinkWrap: true,
  //                       physics: NeverScrollableScrollPhysics(),
  //                       itemCount: lessons.length,
  //                       itemBuilder: (context, index) {
  //                         Lesson lesson = lessons[index];
  //                         return ListTile(
  //                           title: Text(lesson.name),
  //                           subtitle: Text(lesson.details),
  //                           trailing: IconButton(
  //                             icon: lesson.completed
  //                                 ? Icon(Icons.check_circle)
  //                                 : Icon(Icons.radio_button_unchecked),
  //                             onPressed: () {},
  //                           ),
  //                         );
  //                       },
  //                     );
  //                   }
  //                 },
  //               );
  //             }
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }

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
