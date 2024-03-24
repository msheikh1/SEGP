import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_school/Screens/Teacher/Students.dart';
import 'package:flutter_school/Screens/Authetication/authenticate.dart';
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
              child: _buildStudentDataContainer(),
            ),
          ],
        ),
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

  Widget _buildStudentDataContainer() {
    return FutureBuilder<Stream<QuerySnapshot>>(
      future: _databaseService.getStudents(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return StreamBuilder(
            stream: snapshot.data,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                List<QueryDocumentSnapshot<Object?>> documents =
                    snapshot.data?.docs ?? [];
                if (documents.isEmpty) {
                  return Center(child: Text('No students found.'));
                } else {
                  return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      final children studentData =
                          documents[index].data() as children;
                      if (studentData != null) {
                        final String name = studentData.name ?? 'Unknown Name';
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/profile_pic.jpg'),
                          ),
                          title: Text(name),
                          onTap: () {},
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  );
                }
              }
            },
          );
        }
      },
    );
  }
}
