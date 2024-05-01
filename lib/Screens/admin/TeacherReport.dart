import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_school/services/database.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:printing/printing.dart';

class TeacherReportScreen extends StatelessWidget {
  final String teacherName;

  const TeacherReportScreen({Key? key, required this.teacherName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DatabaseService _database = DatabaseService();

    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher Report'),
        actions: [
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () => _printDocument(context),
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _database.generateTeacherReport(teacherName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            Map<String, dynamic> report = snapshot.data!;
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Teacher: ${report['teacherName']}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Total Lessons: ${report['totalLessons']}',
                  ),
                  Text(
                    'Completed Lessons: ${report['completedLessons']}',
                  ),
                  Text(
                    'Uncompleted Lessons: ${report['uncompletedLessons']}',
                  ),
                  Text(
                    'Completion Percentage: ${report['completedPercentage']}%',
                  ),
                  Text(
                    'Uncompletion Percentage: ${report['uncompletedPercentage']}%',
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Students:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: report['students'].length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(report['students'][index]),
                      );
                    },
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Completed vs. Uncompleted Lessons:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  _buildPieChart(context, report['completedLessons'],
                      report['uncompletedLessons']),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildPieChart(
      BuildContext context, int completedLessons, int uncompletedLessons) {
    Map<String, double> dataMap = {
      'Completed Lessons': completedLessons.toDouble(),
      'Uncompleted Lessons': uncompletedLessons.toDouble(),
    };

    List<Color> colorList = [
      Colors.green, // Completed
      Colors.red, // Uncompleted
    ];

    return PieChart(
      dataMap: dataMap,
      colorList: colorList,
      chartType: ChartType.disc,
      chartRadius: MediaQuery.of(context).size.width / 3.2,
      initialAngleInDegree: 0,
      animationDuration: Duration(milliseconds: 800),
      chartLegendSpacing: 32,
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: true,
        showChartValues: true,
        showChartValuesInPercentage: true,
        showChartValuesOutside: false,
      ),
    );
  }

  Future<void> _printDocument(BuildContext context) async {
    final doc = await _buildDocument(context);
    Printing.sharePdf(
      bytes: doc,
      filename: 'teacher_report.pdf',
    );
  }

  Future<Uint8List> _buildDocument(BuildContext context) async {
    final Completer<Uint8List> completer = Completer();
    final GlobalKey key = GlobalKey();

    await Future.delayed(Duration(milliseconds: 100));
    // Use another method to capture the widget as an image
    // For example, you can use screenshot package: https://pub.dev/packages/screenshot
    // Convert the screenshot to Uint8List and return it
    completer
        .complete(Uint8List(0)); // Placeholder, replace with actual Uint8List
    return completer.future;
  }
}
