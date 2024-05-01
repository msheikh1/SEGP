import 'package:flutter/material.dart';
import 'package:flutter_school/models/classStructure.dart';

// This widget represents the LessonScreen application.
class LessonScreen extends StatefulWidget {
  // The function to be executed when the back button is tapped.
  final Function(int)? onBack;
  // The lesson to be displayed.
  final Lesson lesson;

  // Constructor for the LessonScreen class.
  const LessonScreen({
    Key? key,
    this.onBack,
    required this.lesson,
  }) : super(key: key);

  @override
  _LessonScreenState createState() => _LessonScreenState();
}

// This widget represents the state of the LessonScreen application.
class _LessonScreenState extends State<LessonScreen> {
  @override
  Widget build(BuildContext context) {
    // Returns a Scaffold widget that contains the lesson details.
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Display the title for the screen.
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
            Expanded(
              child: ListTile(
                // Display the name of the lesson.
                title: Text(widget.lesson.name),
                // Display the details of the lesson.
                subtitle: Text(widget.lesson.details),
              ),
            ),
            IconButton(
              // Set the function to be executed when the IconButton is pressed.
              onPressed: () {
                widget.onBack!(8);
              },
              // Set the icon for the IconButton.
              icon: Icon(Icons.edit),
              // Set the color for the IconButton.
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}