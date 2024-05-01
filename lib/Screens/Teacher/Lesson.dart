import 'package:flutter/material.dart';
import 'package:flutter_school/models/classStructure.dart';

class LessonScreen extends StatefulWidget {
  final Function(int)? onBack;
  final Lesson lesson;

  const LessonScreen({
    Key? key,
    this.onBack,
    required this.lesson,
  }) : super(key: key);

  @override
  _LessonScreenState createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
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
