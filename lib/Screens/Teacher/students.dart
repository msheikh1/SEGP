import 'package:flutter/material.dart';
import 'package:flutter_school/Screens/MainScreenState.dart';

class StudentsScreen extends StatelessWidget {
  final Function(int)? onStudentTap;

  const StudentsScreen({Key? key, this.onStudentTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Text(
                    'Your Students',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            FutureBuilder<List<Student>>(
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
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Student student = snapshot.data![index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(student.profilePicUrl),
                          ),
                          title: Text(student.name),
                          onTap: () {
                            onStudentTap?.call(5);
                          },
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
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
