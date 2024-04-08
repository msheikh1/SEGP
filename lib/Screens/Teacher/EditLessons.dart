import 'package:flutter/material.dart';
import 'package:flutter_school/models/classStructure.dart';
import 'package:flutter_school/services/database.dart';

class EditLessonScreen extends StatefulWidget {
  final Function(int)? onBack;
  final Lesson lesson;

  const EditLessonScreen({
    Key? key,
    this.onBack,
    required this.lesson,
  }) : super(key: key);

  @override
  _EditLessonScreen createState() => _EditLessonScreen();
}

class _EditLessonScreen extends State<EditLessonScreen> {
  late TextEditingController nameController;
  late TextEditingController detailsController;
  late Lesson updatedLesson;
  final DatabaseService _databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.lesson.name);
    detailsController = TextEditingController(text: widget.lesson.details);
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
                  updatedLesson.name = nameController.text;
                  updatedLesson.details = detailsController.text;
                  updatedLesson.month = widget.lesson.month;
                  updatedLesson.completed = widget.lesson.completed;
                  updatedLesson.teacher = widget.lesson.teacher;
                  _databaseService.updateLesson(widget.lesson, updatedLesson);
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
                  _databaseService.deleteELesson(widget.lesson);
                  widget.onBack?.call(3);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                ),
                child: Text('Delete', style: TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: ElevatedButton(
                onPressed: () {
                  widget.onBack?.call(4);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                ),
                child: Text('Back', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
