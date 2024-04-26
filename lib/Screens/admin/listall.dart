import 'package:flutter/material.dart';
import 'package:flutter_school/services/database.dart';

class TeachersAndStudentsScreen extends StatefulWidget {
  @override
  _TeachersAndStudentsScreenState createState() =>
      _TeachersAndStudentsScreenState();
}

class _TeachersAndStudentsScreenState extends State<TeachersAndStudentsScreen> {
  DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Teachers and Students',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<List<String>>(
        future: _getTeachersAndStudents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<String>? teachersAndStudents = snapshot.data;
            if (teachersAndStudents == null || teachersAndStudents.isEmpty) {
              return Center(child: Text('No data available'));
            } else {
              return ListView.builder(
                itemCount: teachersAndStudents.length,
                itemBuilder: (context, index) {
                  String teacherAndStudents = teachersAndStudents[index];
                  return Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ExpansionTile(
                      title: Text(
                        teacherAndStudents.split(':')[0],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      children: _buildStudentTiles(
                        teacherAndStudents.split(':')[1].trim().split(', '),
                      ),
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }

  List<Widget> _buildStudentTiles(List<String> students) {
    List<Widget> tiles = [];
    for (String student in students) {
      tiles.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text(
            student,
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }
    return tiles;
  }

  Future<List<String>> _getTeachersAndStudents() async {
    List<String> teachersAndStudents = [];
    List<String> teachers = await _databaseService.getTeachersList();

    for (String teacher in teachers) {
      List<String> students = await _databaseService.getStudentsList(teacher);
      teachersAndStudents.add('$teacher: ${students.join(", ")}');
    }

    return teachersAndStudents;
  }
}
