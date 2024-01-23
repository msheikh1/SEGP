import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_school/main.dart';
import 'package:provider/provider.dart';

class TeacherScreen extends StatelessWidget {
  const TeacherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset("assets/images/login_top_right.png"),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                "assets/images/main_bottom.png",
                width: size.width * 0.3,
              ),
            ),
            // Curved edges box with dynamic table
            Positioned(
              top: 50,
              left: 20,
              right: 20, // Custom clipper for curved edges
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 123, 0, 255),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dynamic Table',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Add your dynamic table or ListView here
                    // Example using DataTable:
                    DataTable(
                      columns: [
                        DataColumn(label: Text('Column 1')),
                        DataColumn(label: Text('Column 2')),
                        // Add more columns as needed
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Text('Data 1')),
                          DataCell(Text('Data 2')),
                          // Add more data cells as needed
                        ]),
                        DataRow(cells: [
                          DataCell(Text("hello1")),
                          DataCell(Text("hello2")),
                        ])
                        // Add more rows as needed
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
