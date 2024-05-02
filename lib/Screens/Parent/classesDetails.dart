import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_school/models/class_structure.dart';
import 'package:flutter_school/services/database.dart';

// This widget represents the details of the classes for a parent.
class ClassesDetails extends StatefulWidget {
  // The function to be executed when a student is tapped.
  final Function(Lesson, int)? onStudentTap;
  // The function to be executed when the add button is tapped.
  final Function(String, int)? onAddTap;
  // The function to be executed when the back button is tapped.
  final Function(int)? onBack;
  // The month for the classes.
  final String month;
  // The child for the classes.
  final String child;

  // Constructor for the ClassesDetails class.
  const ClassesDetails({
    Key? key,
    required this.child,
    this.onStudentTap,
    this.onAddTap,
    this.onBack,
    required this.month,
  }) : super(key: key);

  @override
  _ClassesDetailsState createState() => _ClassesDetailsState();
}

// This widget represents the state of the ClassesDetails application.
class _ClassesDetailsState extends State<ClassesDetails> {
  // The service for the database.
  final DatabaseService _databaseService = DatabaseService();
  // The list of teachers.
  late List<String> teachers = [];

  @override
  void initState() {
    super.initState();
    // Initialize the teachers.
    _initializeTeachers();
  }

  // This function initializes the teachers.
  Future<void> _initializeTeachers() async {
    try {
      // Fetch the teachers for the child.
      List<String>? fetchedTeachers =
          await _databaseService.getTeachers(widget.child);
      if (fetchedTeachers != null) {
        setState(() {
          teachers = fetchedTeachers;
        });
      } else {
        // Handle null value or error case
      }
    } catch (e) {
      // Handle exception
      print("Error fetching teachers: $e");
    }
  }

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
              child: ListView.builder(
                itemCount: teachers.length,
                itemBuilder: (context, index) {
                  return FutureBuilder<Stream<QuerySnapshot<Lesson>>>(
                    future:
                        _databaseService.getLessonsForTeachers(teachers[index]),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        final stream = snapshot.data;
                        if (stream == null) {
                          return Center(
                            child: Text("No Lessons"),
                          );
                        }
                        return StreamBuilder<QuerySnapshot<Lesson>>(
                          stream: stream,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              final List<Lesson> lessons = snapshot.data?.docs
                                      .map((doc) => doc.data())
                                      .toList() ??
                                  [];
                              if (lessons.isEmpty) {
                                return Center(
                                  child: Text("No Lessons"),
                                );
                              }
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: lessons.length,
                                itemBuilder: (context, index) {
                                  Lesson lesson = lessons[index];
                                  if (lesson.month == widget.month) {
                                    return ListTile(
                                      title: Text(lesson.name),
                                      subtitle: Text(lesson.details),
                                      trailing: IconButton(
                                        icon: lesson.completed
                                            ? Icon(Icons.check_circle)
                                            : Icon(
                                                Icons.radio_button_unchecked),
                                        onPressed: () {},
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
                          },
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}