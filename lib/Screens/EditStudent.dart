// Import necessary packages
import 'package:flutter/material.dart';

// EditStudentScreen is a stateful widget that displays the student editing interface
class EditStudentScreen extends StatefulWidget {
  // initialData is a required parameter that contains the initial student data
  // onEdit is an optional callback function that is called when the student data is edited
  // onStudentTap is an optional callback function that is called when the student is tapped
  final List<String> initialData;
  final Function(List<String>)? onEdit;
  final Function(int)? onStudentTap;

  // Constructor
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
  // Controllers for the name, age, and classes input fields
  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController classesController;

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with the initial student data
    nameController = TextEditingController(text: widget.initialData[0]);
    ageController = TextEditingController(text: widget.initialData[1]);
    classesController = TextEditingController(text: widget.initialData[2]);
  }

  // Build method
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
            // Display the title
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
            // Name input field
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            // Age input field
            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: 'Age'),
            ),
            // Classes input field
            TextField(
              controller: classesController,
              decoration: InputDecoration(labelText: 'Classes'),
            ),
            SizedBox(height: 16.0),
            // Save button
            ElevatedButton(
              onPressed: () {
                // Get the edited data
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