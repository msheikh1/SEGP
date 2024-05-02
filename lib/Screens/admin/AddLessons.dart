import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_school/models/class_structure.dart';
import 'package:flutter_school/services/database.dart';
import 'package:flutter_school/Screens/Authentication/authenticate.dart';

// This widget is the root of the AddLesson application.
class AddLesson extends StatefulWidget {
  // The month for the lessons.
  final String month;
  // The function to be executed when a student is tapped.
  final Function(int)? onStudentTap;

  // Constructor for the AddLesson class.
  const AddLesson({
    Key? key,
    this.onStudentTap,
    required this.month,
  }) : super(key: key);

  @override
  _NewLessonScreenState createState() => _NewLessonScreenState();
}

// This widget is the home page of the AddLesson application.
class _NewLessonScreenState extends State<AddLesson> {
  // The key for the form.
  final _formKey = GlobalKey<FormState>();
  // The name of the lesson.
  late String _lessonName;
  // The details of the lesson.
  late String _lessonDetails;
  // The teacher of the lesson.
  late String _teacher;
  // The completion status of the lesson.
  bool _completed = false;
  // The service for the database.
  final DatabaseService _databaseService = DatabaseService();
  // The service for the authentication.
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    // Returns a Scaffold widget that contains the form for adding a new lesson.
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Lesson'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Month: ${widget.month}',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(labelText: 'Lesson Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the lesson name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _lessonName = value!;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'Lesson Details'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the lesson details';
                  }
                  return null;
                },
                onSaved: (value) {
                  _lessonDetails = value!;
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Lesson newLesson = new Lesson(
                        name: _lessonName,
                        details: _lessonDetails,
                        teacher: 'admin',
                        month: widget.month,
                        completed: _completed);

                    _databaseService.addLesson(newLesson);
                    // Add the lesson to your database or wherever you need to
                    // You can access the entered values as _lessonName, _lessonDetails, _teacher, _completed
                    // For demonstration, I'll print them here
                    // You can also navigate back to the previous screen
                    widget.onStudentTap?.call(3);
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // This function returns the name for the lesson.
  Future<String> getnameforLesson() async {
    final User? user = _authService.getCurrentUser();
    String name = "Unknown User"; // Default value

    if (user != null) {
      name = await _databaseService.getUserName(user) ?? name;
    }
    return name;
  }
}