import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_school/Screens/MainScreenState.dart';

class ClassesScreen extends StatelessWidget {
  final Function(int)? onStudentTap;

  const ClassesScreen({Key? key, this.onStudentTap}) : super(key: key);

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
                    'Your Classes',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            FutureBuilder<List<Classes>>(
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
                        Classes classes = snapshot.data![index];
                        return ListTile(
                          title: Text(classes.name),
                          subtitle: Text(classes.year),
                          onTap: () {
                            onStudentTap?.call(3);
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

  Future<List<Classes>> fetchDataFromFirebase() async {
    // Simulating fetching data from Firebase
    await Future.delayed(Duration(seconds: 2));
    return [
      Classes(name: 'Mathematics', year: '2'),
      Classes(name: 'Science', year: '1'),
      Classes(name: 'English', year: '1'),
    ];
  }
}

class Classes {
  final String name;
  final String year;

  Classes({required this.name, required this.year});
}
