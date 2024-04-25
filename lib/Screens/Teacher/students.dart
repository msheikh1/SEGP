import 'package:flutter/material.dart';
import 'package:flutter_school/models/classStructure.dart';

class Students extends StatelessWidget {
  final Function(Student)? onStudentTap;
  final List<Lesson> data;
  const Students({Key? key, this.onStudentTap, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: FutureBuilder<List<Student>>(
        future: fetchDataFromFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While data is being fetched, show a loading spinner
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // If an error occurs during fetching, display an error message
            return Text('Error: ${snapshot.error}');
          } else {
            // If data is successfully fetched, show the list
            List<Student>? StudentList = snapshot.data;
            if (StudentList != null && StudentList.isNotEmpty) {
              return ListView.builder(
                itemCount: StudentList.length,
                itemBuilder: (context, index) {
                  Student student = StudentList[index];

                  return ListTile(
                      title: Text(student.name),
                      onTap: () => onStudentTap?.call(student));
                },
              );
            } else {
              return Text('No classes found.');
            }
          }
        },
      ),
    ));
  }

  Future<List<Student>> fetchDataFromFirebase() async {
    // Simulating fetching data from Firebase
    await Future.delayed(Duration(seconds: 2));
    return [
      Student(name: 'Student 1', profilePicUrl: 'URL_TO_PROFILE_PIC_1'),
      Student(name: 'Student 2', profilePicUrl: 'URL_TO_PROFILE_PIC_2'),
      Student(name: 'Student 3', profilePicUrl: 'URL_TO_PROFILE_PIC_3'),
    ];
  }
}

class Student {
  final String name;
  final String profilePicUrl;

  Student({required this.name, required this.profilePicUrl});
}
