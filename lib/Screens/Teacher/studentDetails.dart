import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_school/Screens/Authentication/authenticate.dart';
import 'package:flutter_school/Screens/Teacher/Students.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_school/models/classStructure.dart';
import 'package:flutter_school/services/database.dart';

class StudentDetails extends StatefulWidget {
  final Function(String, int)? onStudentTap;

  const StudentDetails({Key? key, this.onStudentTap}) : super(key: key);

  @override
  StudentDetailsState createState() => StudentDetailsState();
}

class StudentDetailsState extends State<StudentDetails> {
  final DatabaseService _databaseService = DatabaseService();
  final AuthService _authService = AuthService();
  late List<String> _students = [];

  @override
  void initState() {
    super.initState();
    _fetchStudents();
  }

  Future<void> _fetchStudents() async {
    User? user = _authService.getCurrentUser();
    if (user != null) {
      List<String>? students = await _databaseService.getStudents(user);
      setState(() {
        _students = students ?? [];
      });
    }
  }

  Future<void> _addTeacherToStudent(String studentName) async {
    User? user = _authService.getCurrentUser();
    if (user != null) {
      // Get teacher's name
      String teacherName = '';
      String? teacherNametry = await _databaseService.getUserName(user);
      if (teacherNametry != null) {
        teacherName = teacherNametry;
      }
      // Add teacher's name to student's document in children database
      await _databaseService.addTeacherToStudent(studentName, teacherName);
      // Fetch updated student list
      await _fetchStudents();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTitleContainer(),
            Expanded(
              child: _buildStudentList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showStudentsDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildTitleContainer() {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 149, 90, 160),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'Student Details',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildStudentList() {
    if (_students.isEmpty) {
      return Center(child: Text('No students found.'));
    } else {
      return ListView.builder(
        itemCount: _students.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_students[index]),
            onTap: () {},
          );
        },
      );
    }
  }

  Future<void> _showStudentsDialog() async {
    List<String>? allStudents = await _databaseService.getAllStudents();
    if (allStudents != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Select Student'),
            content: SingleChildScrollView(
              child: Column(
                children: allStudents
                    .map(
                      (student) => ListTile(
                        title: Text(student),
                        onTap: () {
                          Navigator.of(context).pop();
                          _addTeacherToStudent(student);
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to fetch students.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
