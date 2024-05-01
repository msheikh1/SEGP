// Import necessary packages
import 'package:flutter/material.dart';

// ClassesScreen is a stateless widget that displays the classes interface
class ClassesScreen extends StatelessWidget {
  // onStudentTap is an optional callback function
  final Function(String)? onStudentTap;

  // Constructor
  ClassesScreen({Key? key, this.onStudentTap}) : super(key: key);

  // Build method
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Months'),
          bottom: TabBar(
            // Define the tabs
            tabs: [
              Tab(text: 'Cycle 1'),
              Tab(text: 'Cycle 2'),
              Tab(text: 'Cycle 3'),
              Tab(text: 'Cycle 4'),
            ],
          ),
        ),
        body: TabBarView(
          // Define the content of each tab
          children: [
            _buildCycle(['January', 'February', 'March']),
            _buildCycle(['April', 'May', 'June']),
            _buildCycle(['July', 'August', 'September']),
            _buildCycle(['October', 'November', 'December']),
          ],
        ),
      ),
    );
  }

  // Function to build the content of a cycle
  Widget _buildCycle(List<String> months) {
    return ListView.builder(
      itemCount: months.length,
      itemBuilder: (context, index) {
        // Get the month at the current index
        final month = months[index];
        return ListTile(
          title: Text(month),
          onTap: () {
            // Call the onStudentTap function when the list tile is tapped
            onStudentTap?.call(month);
          },
        );
      },
    );
  }
}