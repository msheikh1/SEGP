import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_school/models/classStructure.dart';
import 'package:flutter_school/services/database.dart';
import 'package:flutter_school/Screens/Authentication/authenticate.dart';

class AddLesson extends StatefulWidget {
  final String month;
  final Function(int)? onStudentTap;

  const AddLesson({
    Key? key,
    this.onStudentTap,
    required this.month,
  }) : super(key: key);

  @override
  _NewLessonScreenState createState() => _NewLessonScreenState();
}

class _NewLessonScreenState extends State<AddLesson> {
  final _formKey = GlobalKey<FormState>();
  late String _lessonName;
  late String _lessonDetails;
  late String _teacher;
  bool _completed = false;
  final DatabaseService _databaseService = DatabaseService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
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

  Future<String> getnameforLesson() async {
    final User? user = _authService.getCurrentUser();
    String name = "Unknown User"; // Default value

    if (user != null) {
      name = await _databaseService.getUserName(user) ?? name;
    }
    return name;
  }
}
