import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_school/models/class_structure.dart';
import 'package:flutter_school/services/database.dart';

// Define the theme colors and style
const Color primaryColor = Color(0xFF15285D); // Deep blue color
const Color secondaryColor = Color(0xFFEEE8E8); // Light accent color
const TextStyle titleStyle =
    TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor);
const TextStyle buttonTextStyle =
    TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white);
const TextStyle detailTextStyle =
    TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: primaryColor);
const double chartRadius = 140; // Increase the radius for a larger chart

class StudentAttendance extends StatefulWidget {
  final String studentName;

  StudentAttendance({Key? key, required this.studentName}) : super(key: key);

  @override
  _StudentAttendanceState createState() => _StudentAttendanceState();
}

class _StudentAttendanceState extends State<StudentAttendance> {
  late attendancedata attendanceData;
  DatabaseService database = DatabaseService();

  bool isLoading = true;

  Future<void> _fetchData() async {
    // Use your DatabaseService to fetch attendance data for the student
    attendancedata? data = await database.getAttendance(widget.studentName);
    print(data);
    setState(() {
      attendanceData = data!;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    } else {
      return AttendanceChart(
        studentName: widget.studentName,
        totalDays: attendanceData.totalDays,
        absentDays: attendanceData.absentDays,
        presentDays: attendanceData
            .presentDays, // Assuming data is not null after fetching
      );
    }
  }
}

// Helper function to create a material color from a single color
MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}

class AttendanceChart extends StatefulWidget {
  final String studentName;
  final int totalDays;
  int absentDays;
  final int presentDays;

  AttendanceChart({
    Key? key,
    required this.studentName,
    required this.totalDays,
    required this.absentDays,
    required this.presentDays,
  }) : super(key: key);

  @override
  _AttendanceChartState createState() => _AttendanceChartState();
}

class _AttendanceChartState extends State<AttendanceChart> {
  bool hasAppliedForLeave =
      false; // State to track if leave has been applied for the day

  void _applyForLeave() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Apply for Leave'),
          content: Text('Please confirm if you would like to apply for leave.'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                setState(() {
                  widget.absentDays++; // Increase the absent days by 1
                  hasAppliedForLeave = true; // Mark leave as applied
                });
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Graph', style: TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 26.0), // Padding at the top if necessary
          Text(
            widget.studentName,
            style: titleStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 45), // Reduced gap between name and pie chart
          SizedBox(
            height: 300.0,
            child: PieChart(
              PieChartData(
                sectionsSpace: 0,
                centerSpaceRadius: 0,
                startDegreeOffset: -90,
                sections: [
                  PieChartSectionData(
                    color: Colors.green,
                    value: double.parse(widget.presentDays.toString()),
                    title: 'Present',
                    titleStyle: buttonTextStyle,
                    radius: chartRadius,
                  ),
                  PieChartSectionData(
                    color: Colors.red,
                    value: double.parse(widget.absentDays.toString()),
                    title: 'Absent',
                    titleStyle: buttonTextStyle,
                    radius: chartRadius,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 50), // Space between the chart and the details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'Absent: ${widget.absentDays}',
                style:
                    detailTextStyle.copyWith(color: Colors.red, fontSize: 21),
              ),
              Text(
                'Present: ${widget.presentDays}',
                style:
                    detailTextStyle.copyWith(color: Colors.green, fontSize: 21),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'Total days: ${widget.totalDays}',
            style: detailTextStyle.copyWith(color: Colors.black, fontSize: 21),
          ),
          SizedBox(height: 26),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: hasAppliedForLeave
                  ? Colors.grey
                  : primaryColor, // Text color
              padding: EdgeInsets.symmetric(
                  horizontal: 30, vertical: 15), // Increase padding
              textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold), // Increase font size
            ),
            onPressed: hasAppliedForLeave
                ? null
                : _applyForLeave, // Disable button if leave is applied
            child: Text('Apply for Leave'),
          ),
        ],
      ),
    );
  }
}
