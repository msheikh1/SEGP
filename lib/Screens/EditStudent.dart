import 'package:flutter/material.dart';

class EditStudentScreen extends StatefulWidget {
  final List<String> initialData;
  final Function(List<String>)? onEdit;
  final Function(int)? onStudentTap;

  const EditStudentScreen({
    Key? key,
    required this.initialData,
    this.onEdit,
    this.onStudentTap,
  }) : super(key: key);

  @override
  _EditStudentScreenState createState() => _EditStudentScreenState();
}

class _EditStudentScreenState extends State<EditStudentScreen> {
  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController classesController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.initialData[0]);
    ageController = TextEditingController(text: widget.initialData[1]);
    classesController = TextEditingController(text: widget.initialData[2]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Student'),
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
                'Edit Student',
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
              controller: ageController,
              decoration: InputDecoration(labelText: 'Age'),
            ),
            TextField(
              controller: classesController,
              decoration: InputDecoration(labelText: 'Classes'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final editedData = [
                  nameController.text,
                  ageController.text,
                  classesController.text,
                ];

                // Invoke the callback to pass back the edited data to the parent screen
                if (widget.onEdit != null) {
                  widget.onEdit?.call(editedData);
                }

                // Pop the current screen
                widget.onStudentTap?.call(3);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
              ),
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
