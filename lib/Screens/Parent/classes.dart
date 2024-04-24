import 'package:flutter/material.dart';

class ClassesScreen extends StatelessWidget {
  final Function(String)? onStudentTap;

  ClassesScreen({Key? key, this.onStudentTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Months'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Cycle 1'),
              Tab(text: 'Cycle 2'),
              Tab(text: 'Cycle 3'),
              Tab(text: 'Cycle 4'),
            ],
          ),
        ),
        body: TabBarView(
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

  Widget _buildCycle(List<String> months) {
    return ListView.builder(
      itemCount: months.length,
      itemBuilder: (context, index) {
        final month = months[index];
        return ListTile(
          title: Text(month),
          onTap: () {
            onStudentTap?.call(month);
          },
        );
      },
    );
  }
}
