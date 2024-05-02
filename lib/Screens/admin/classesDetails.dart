import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_school/models/class_structure.dart';
import 'package:flutter_school/services/database.dart';
import 'package:flutter_school/Screens/Authentication/authenticate.dart';

// This widget represents the ClassesDetails application.
class ClassesDetails extends StatefulWidget {
  // The function to be executed when a student is tapped.
  final Function(Lesson, int)? onStudentTap;
  // The function to be executed when the add button is tapped.
  final Function(String, int)? onAddTap;
  // The function to be executed when the back button is tapped.
  final Function(int)? onBack;
  // The month for the classes.
  final String month;

  // Constructor for the ClassesDetails class.
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

// This widget represents the state of the ClassesDetails application.
class _ClassesDetailsState extends State<ClassesDetails> {
  // The service for the database.
  final DatabaseService _databaseService = DatabaseService();
  // The service for the authentication.
  final AuthService _authService = AuthService();
  // The current user.
  late User user;
  // The name of the user.
  late String name;

  @override
  Widget build(BuildContext context) {
    // Returns a Scaffold widget that contains the classes details.
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
            TextButton(
                onPressed: () {
                  widget.onAddTap?.call(widget.month, 7);
                },
                child: Icon(Icons.add)),
          ],
        ),
      ),
    );
  }
}