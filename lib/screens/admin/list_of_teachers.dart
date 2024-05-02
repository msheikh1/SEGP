import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_school/services/database.dart'; // Import your DatabaseService
import 'package:flutter_school/Screens/Authentication/authenticate.dart';

// This widget represents the TeachersListScreen application.
class TeachersListScreen extends StatelessWidget {
  // The function to be executed when a student is tapped.
  final Function(String, int) onStudentTap; // Updated to return teacher's name

  // Constructor for the TeachersListScreen class.
  const TeachersListScreen({Key? key, required this.onStudentTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // The service for the database.
    DatabaseService _database = DatabaseService();
    // The service for the authentication.
    AuthService _authService = AuthService();

    // The current user.
    User? user = _authService.getCurrentUser();

    // Returns a Scaffold widget that contains the teachers list.
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Teachers List'),
      ),
      body: FutureBuilder<List<String>>(
        // Fetch the teacher names from the database.
        future: _database.fetchTeacherNames(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            if (user == null) {
              return Center(
                child: Text(
                    'User not authenticated. Please login to view teachers list.'),
              );
            }
            // The list of teachers.
            List<String> teachersList = snapshot.data!;
            return ListView.builder(
              itemCount: teachersList.length,
              itemBuilder: (context, index) {
                // The name of the teacher.
                String teacherName = teachersList[index];
                return ListTile(
                  leading: FutureBuilder<String>(
                    // Fetch the profile image URL.
                    future: _database.getUserProfileImageUrl(
                        user), // Fetch profile image URL
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircleAvatar(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return CircleAvatar(
                          child:
                              Icon(Icons.person), // Placeholder icon for error
                        );
                      } else {
                        // The URL of the profile image.
                        String? profileImageUrl = snapshot.data;
                        return CircleAvatar(
                          backgroundImage: profileImageUrl != null
                              ? NetworkImage(profileImageUrl)
                              : AssetImage('assets/default_profile_icon.png')
                                  as ImageProvider,
                        );
                      }
                    },
                  ),
                  title: Text(teacherName),
                  onTap: () {
                    // Call the onTap function and pass the teacher's name.
                    onStudentTap(teacherName, 5);
                    // Navigate to the teacher profile screen.
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}