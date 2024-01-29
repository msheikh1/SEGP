import 'package:flutter/material.dart';
import 'package:flutter_school/Screens/Teacher/classes.dart';

class ClassesDetails extends StatelessWidget {
  final Function(int)? onStudentTap;
  final String classId; // Class identifier passed from the previous page

  const ClassesDetails({Key? key, this.onStudentTap, required this.classId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            FutureBuilder<List<Lesson>>(
              future: fetchDataFromFirebase(
                  classId), // Pass the classId to fetch lessons for this class
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
                  // If data is successfully fetched, show the list of lessons
                  List<Lesson> lessonsList = snapshot.data!;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: lessonsList.length,
                      itemBuilder: (context, index) {
                        Lesson lesson = lessonsList[index];
                        return ListTile(
                          title: Text(lesson.name),
                          subtitle: Text(lesson.details),
                          trailing: lesson.attendanceMarked
                              ? Icon(Icons.check_circle, color: Colors.green)
                              : IconButton(
                                  icon: Icon(Icons.radio_button_unchecked),
                                  onPressed: () {
                                    // Mark attendance when the button is pressed
                                    // Here, you might implement logic to mark attendance in Firebase
                                    // For simplicity, let's update the local state
                                    markAttendance(index, lessonsList);
                                  },
                                ),
                          onTap: () {
                            onStudentTap?.call(4);
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

  Future<List<Lesson>> fetchDataFromFirebase(String classId) async {
    // Simulate fetching lessons for the specified class from Firebase
    await Future.delayed(Duration(seconds: 2));
    // Return a list of sample lessons (replace this with actual Firebase data retrieval)
    return [
      Lesson(
        name: 'Lesson 1',
        details: 'Lesson 1 details',
        attendanceMarked:
            true, // Example: Attendance already marked for Lesson 1
      ),
      Lesson(
        name: 'Lesson 2',
        details: 'Lesson 2 details',
      ),
      Lesson(
        name: 'Lesson 3',
        details: 'Lesson 3 details',
      ),
    ];
  }

  void markAttendance(int index, List<Lesson> lessonsList) {
    // Update the attendance flag for the selected lesson
    Lesson selectedLesson = lessonsList[index];
    selectedLesson.attendanceMarked = true;
    // You may want to implement Firebase update logic here to mark attendance
  }
}

class Lesson {
  final String name;
  final String details;
  bool attendanceMarked;

  Lesson({
    required this.name,
    required this.details,
    this.attendanceMarked = false,
  });
}
