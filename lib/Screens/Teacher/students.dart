import 'package:flutter/material.dart';
import 'package:flutter_school/Screens/MainScreenState.dart';

class StudentsScreen extends StatelessWidget {
  final Function(int)? onStudentTap;

  const StudentsScreen({Key? key, this.onStudentTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            FutureBuilder<List<String>>(
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
                        String studentName = snapshot.data![index];
                        return ListTile(
                          title: Text(studentName),
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

  Future<List<String>> fetchDataFromFirebase() async {
    // Simulating fetching data from Firebase
    await Future.delayed(Duration(seconds: 2));
    return ['Student 1', 'Student 2', 'Student 3'];
  }
}
