// Import necessary packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_school/models/class_structure.dart';
import 'package:flutter_school/services/database.dart';
import 'package:flutter_school/Screens/Authentication/authenticate.dart';

// ClassesDetails is a stateful widget that displays the details of the classes
class ClassesDetails extends StatefulWidget {
  // Callback functions for various user interactions
  final Function(Lesson, int)? onStudentTap;
  final Function(String, int)? onAddTap;
  final Function(int)? onBack;
  final String month;

  // Constructor
  const ClassesDetails(
      {Key? key,
      this.onStudentTap,
      this.onAddTap,
      this.onBack,
      required this.month})
      : super(key: key);

  @override
  _ClassesDetailsState createState() => _ClassesDetailsState();
}

class _ClassesDetailsState extends State<ClassesDetails> {
  // Instances of database and auth services
  final DatabaseService _databaseService = DatabaseService();
  final AuthService _authService = AuthService();
  late User user;
  late String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Text(
                    'Your Lessons',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            // Display the lessons
            Expanded(
              child: FutureBuilder(
                  future: _databaseService.getLessons(),
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
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                              if (lesson.month == widget.month) {
                                counter++;
                                return ListView.builder(
                                  itemCount: lessons.length,
                                  itemBuilder: (context, index) {
                                    Lesson lesson = lessons[index].data();
                                    if (lesson.month == widget.month) {
                                      return ListTile(
                                        title: Text(lesson.name),
                                        subtitle: Text(lesson.details),
                                        trailing: IconButton(
                                          icon: lesson.completed
                                              ? Icon(Icons.check_circle)
                                              : Icon(
                                                  Icons.radio_button_unchecked),
                                          onPressed: () {
                                            setState(() {
                                              lesson.completed =
                                                  !lesson.completed;
                                              _databaseService.updateLesson(
                                                  lesson, lesson);
                                            });
                                          },
                                        ),
                                        onTap: () {
                                          widget.onStudentTap?.call(lesson, 10);
                                        },
                                      );
                                    } else {
                                      return SizedBox.shrink();
                                    }
                                  },
                                );
                              }
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
            ),
          ],
        ),
      ),
    );
  }
}