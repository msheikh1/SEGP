// Import necessary packages
import 'package:flutter/material.dart';
import 'package:flutter_school/models/class_structure.dart';

// LessonScreen is a stateful widget that displays the lesson details
class LessonScreen extends StatefulWidget {
  // onBack is an optional callback function
  final Function(int)? onBack;
  // lesson is a required parameter
  final Lesson lesson;

  // Constructor
  const LessonScreen({
    Key? key,
    this.onBack,
    required this.lesson,
  }) : super(key: key);

  @override
  _LessonScreenState createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  // Build method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set the background color
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Display the title
                  Text(
                    'Lesson Details',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            // Display the lesson details
            Expanded(
              child: ListTile(
                title: Text(widget.lesson.name),
                subtitle: Text(widget.lesson.details),
              ),
            ),
          ],
        ),
      ),
    );
  }
}