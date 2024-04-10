import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_school/models/classStructure.dart';

class ClassesScreen extends StatelessWidget {
  final Function(String)? onStudentTap; // Change the type to String
  static List<String> classesArray = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  const ClassesScreen({Key? key, this.onStudentTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: classesArray.length,
          itemBuilder: (context, index) {
            String month = classesArray[index];

            return ListTile(
              title: Text(month),
              onTap: () {
                // Pass the selected month to the callback function
                onStudentTap?.call(month);
              },
            );
          },
        ),
      ),
    );
  }
}
