import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_school/Screens/Authentication/authenticate.dart';
import 'package:flutter_school/Screens/Teacher/Students.dart';
import 'package:flutter_school/services/database.dart';
import 'package:intl/intl.dart';
import 'package:flutter_school/models/classStructure.dart';

class AttendancePage extends StatefulWidget {
  final Function(int) onStudentTap;

  const AttendancePage({Key? key, required this.onStudentTap})
      : super(key: key);
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  List<String> students = [];
  bool isAttendanceConfirmed = false;
  DateTime currentDate = DateTime.now();
  AuthService _authService = AuthService();
  DatabaseService _databaseService = DatabaseService();
  attendance attended = new attendance(date: DateTime.now(), students: []);

  @override
  void initState() {
    super.initState();
    _fetchStudents();
  }

  Future<void> _fetchStudents() async {
    User? user = _authService.getCurrentUser();
    if (user != null) {
      List<String>? student = await _databaseService.getStudents(user);
      print(student);
      setState(() {
        students = student ?? [];
        print(students);

        attended.date = currentDate;
      });
    }
  }

  void updateAttendance(String name) {
    setState(() {
      attended.students.add(name);
    });
  }

  void confirmAttendance() {
    setState(() async {
      isAttendanceConfirmed = true;
      await _databaseService.addAttendance(attended);
      widget.onStudentTap(2);
    });
  }

  void resetAttendance() {
    if (currentDate.day != DateTime.now().day) {
      setState(() {
        isAttendanceConfirmed = false;
        currentDate = DateTime.now();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    resetAttendance();
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Attendance ${DateFormat('yyyy-MM-dd').format(currentDate)}'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: students.isEmpty
                ? Center(
                    child: Text(
                      'No students found.',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 18.0,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      var student = students[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: attended.students.contains(student)
                              ? Colors.green
                              : Colors.blue,
                          child: Text(student[0]), // Assuming name initials
                        ),
                        title: Text(student),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.check, color: Colors.green),
                              onPressed: isAttendanceConfirmed
                                  ? null
                                  : () {
                                      // Check if student is already marked present
                                      if (!attended.students
                                          .contains(student)) {
                                        updateAttendance(student);
                                      }
                                    },
                            ),
                            IconButton(
                              icon: Icon(Icons.close, color: Colors.red),
                              onPressed: () {
                                // Confirmation dialog for removing student
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Remove Student'),
                                      content: Text(
                                          'Are you sure you want to remove $student from attendance?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            // Logic to remove student from server-side attendance (if needed)
                                            setState(() {
                                              attended.students.remove(student);
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: Text('Remove'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          if (!isAttendanceConfirmed)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: SlideToConfirm(onConfirmed: confirmAttendance),
            ),
        ],
      ),
    );
  }
}

class SlideToConfirm extends StatefulWidget {
  final VoidCallback onConfirmed;

  const SlideToConfirm({Key? key, required this.onConfirmed}) : super(key: key);

  @override
  _SlideToConfirmState createState() => _SlideToConfirmState();
}

class _SlideToConfirmState extends State<SlideToConfirm> {
  double _dragExtent = 0.0;
  bool _isCompleted = false;
  bool _isDraggingEnabled = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (!_isDraggingEnabled) return;
        final RenderBox box = context.findRenderObject() as RenderBox;
        setState(() {
          _dragExtent += details.primaryDelta!;
          _dragExtent = _dragExtent.clamp(0.0, box.size.width - 50.0);
        });

        if (_dragExtent == box.size.width - 50.0) {
          _isCompleted = true;
          widget.onConfirmed();
          _isDraggingEnabled = false;
        }
      },
      onHorizontalDragEnd: (details) {
        if (!_isCompleted) {
          setState(() {
            _dragExtent = 0.0;
          });
        }
      },
      child: Container(
        width: double.infinity,
        height: 70.0,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.circular(35.0),
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            AnimatedPositioned(
              left: _dragExtent,
              duration: Duration(milliseconds: 0),
              child: Container(
                width: 50.0,
                height: 50.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.chevron_right,
                  color: Colors.black,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                _isCompleted ? 'Confirmed' : 'Slide to confirm',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
