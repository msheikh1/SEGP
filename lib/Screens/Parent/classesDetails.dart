import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_school/models/classStructure.dart';
import 'package:flutter_school/services/database.dart';

class ClassesDetails extends StatefulWidget {
  final Function(Lesson, int)? onStudentTap;
  final Function(String, int)? onAddTap;
  final Function(int)? onBack;
  final String month;
  final String child;

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

class _ClassesDetailsState extends State<ClassesDetails> {
  final DatabaseService _databaseService = DatabaseService();
  late List<String> teachers = [];

  @override
  void initState() {
    super.initState();
    _initializeTeachers();
  }

  Future<void> _initializeTeachers() async {
    try {
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
            Container(
              alignment: Alignment.topLeft,
              child: ElevatedButton(
                onPressed: () {
                  widget.onBack?.call(0);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                ),
                child: Text('Back', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
