// Import necessary packages
import 'package:flutter/material.dart';
import 'package:flutter_school/models/class_structure.dart';

// Students is a stateless widget that displays the students interface
class Students extends StatelessWidget {
  // onStudentTap is an optional callback function
  final Function(Student)? onStudentTap;
  // data is a required parameter
  final List<Lesson> data;

  // Constructor
  const Students({Key? key, this.onStudentTap, required this.data})
      : super(key: key);

  // Build method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: FutureBuilder<List<Student>>(
        // Fetch the data from Firebase
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
                      // Call the onStudentTap function when the list tile is tapped
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

  // Function to fetch the data from Firebase
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

// Student is a class that represents a student
class Student {
  // name and profilePicUrl are required parameters
  final String name;
  final String profilePicUrl;

  // Constructor
  Student({required this.name, required this.profilePicUrl});
}