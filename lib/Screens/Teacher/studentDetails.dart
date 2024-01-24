import 'package:flutter/material.dart';

class StudentDetails extends StatelessWidget {
  final Function(int)? onStudentTap;
  final List<String> Data;

  const StudentDetails({Key? key, this.onStudentTap, required this.Data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTitleContainer(),
            _buildStudentDataContainer(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleContainer() {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 149, 90, 160),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'Student Details',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildStudentDataContainer() {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 239, 233, 216),
        borderRadius: BorderRadius.circular(12),
      ),
      child: FutureBuilder<List<String>>(
        future: fetchDataFromFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return Text('No data available');
          } else {
            List<String> data = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoText('Name: ${data[0]}'),
                _buildInfoText('Age: ${data[1]}'),
                _buildInfoText('Classes: ${data[2]}'),
                SizedBox(height: 16.0),
                _buildEditButton(),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildInfoText(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 18.0),
    );
  }

  Widget _buildEditButton() {
    return ElevatedButton(
      onPressed: () {
        onStudentTap?.call(4);
      },
      child: Text('Edit'),
    );
  }

  Future<List<String>> fetchDataFromFirebase() async {
    // Simulating fetching data from Firebase
    await Future.delayed(Duration(seconds: 2));
    return Data;
  }
}
