import 'package:flutter/material.dart';
import 'package:flutter_school/models/class_structure.dart';
import 'package:flutter_school/services/database.dart';

// This widget represents the EditLessonScreen application.
class EditLessonScreen extends StatefulWidget {
  // The function to be executed when the back button is tapped.
  final Function(int)? onBack;
  // The lesson to be edited.
  final Lesson lesson;

  // Constructor for the EditLessonScreen class.
  const EditLessonScreen({
    Key? key,
    this.onBack,
    required this.lesson,
  }) : super(key: key);

  @override
  _EditLessonScreen createState() => _EditLessonScreen();
}

// This widget represents the state of the EditLessonScreen application.
class _EditLessonScreen extends State<EditLessonScreen> {
  // The controller for the name text field.
  late TextEditingController nameController;
  // The controller for the details text field.
  late TextEditingController detailsController;
  // The updated lesson.
  late Lesson updatedLesson;
  // The service for the database.
  final DatabaseService _databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with the current lesson's name and details.
    nameController = TextEditingController(text: widget.lesson.name);
    detailsController = TextEditingController(text: widget.lesson.details);
    // Initialize the updated lesson with the current lesson's data.
    updatedLesson = Lesson(
      name: widget.lesson.name,
      details: widget.lesson.details,
      month: widget.lesson.month,
      teacher: widget.lesson.teacher,
      completed: widget.lesson.completed,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Returns a Scaffold widget that contains the form for editing a lesson.
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Lesson'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 16.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Edit Lesson',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: detailsController,
              decoration: InputDecoration(labelText: 'Details'),
            ),
            SizedBox(height: 16.0),
            Container(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  // Update the lesson with the new data and save it to the database.
                  updatedLesson.name = nameController.text;
                  updatedLesson.details = detailsController.text;
                  updatedLesson.month = widget.lesson.month;
                  updatedLesson.completed = widget.lesson.completed;
                  updatedLesson.teacher = widget.lesson.teacher;
                  _databaseService.updateLessonsForAllTeachers(
                      widget.lesson, updatedLesson);
                  widget.onBack?.call(3);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                ),
                child: Text('Save', style: TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: ElevatedButton(
                onPressed: () {
                  // Delete the lesson from the database.
                  _databaseService.deleteLessonFromTeachers(widget.lesson);
                  widget.onBack?.call(3);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                ),
                child: Text('Delete', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}