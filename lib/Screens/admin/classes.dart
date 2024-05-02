import 'package:flutter/material.dart';

// This widget represents the ClassesScreen application.
class ClassesScreen extends StatelessWidget {
  // The function to be executed when a student is tapped.
  final Function(String)? onStudentTap;

  // Constructor for the ClassesScreen class.
  ClassesScreen({Key? key, this.onStudentTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Returns a DefaultTabController widget that contains a Scaffold widget.
    return DefaultTabController(
      // Set the number of tabs.
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // Set the title for the AppBar.
          title: Text('Months'),
          bottom: TabBar(
            // Set the tabs for the TabBar.
            tabs: [
              Tab(text: 'Cycle 1'),
              Tab(text: 'Cycle 2'),
              Tab(text: 'Cycle 3'),
              Tab(text: 'Cycle 4'),
            ],
          ),
        ),
        body: TabBarView(
          // Set the children for the TabBarView.
          children: [
            // Build the cycle for the months.
            _buildCycle(['January', 'February', 'March']),
            _buildCycle(['April', 'May', 'June']),
            _buildCycle(['July', 'August', 'September']),
            _buildCycle(['October', 'November', 'December']),
          ],
        ),
      ),
    );
  }

  // This function builds the cycle for the months.
  Widget _buildCycle(List<String> months) {
    // Returns a ListView.builder widget that contains a ListTile widget for each month.
    return ListView.builder(
      // Set the number of items in the list.
      itemCount: months.length,
      itemBuilder: (context, index) {
        // Get the month at the current index.
        final month = months[index];
        return ListTile(
          // Set the title for the ListTile.
          title: Text(month),
          // Set the function to be executed when the ListTile is tapped.
          onTap: () {
            onStudentTap?.call(month);
          },
        );
      },
    );
  }
}