import 'package:flutter/material.dart';

class StudentDetails extends StatelessWidget {
  final Function(int)? onStudentTap;

  const StudentDetails({Key? key, this.onStudentTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Some Data for the kid",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 24,
                fontWeight: FontWeight.normal,
              ))
        ],
      ),
    );
  }
}
