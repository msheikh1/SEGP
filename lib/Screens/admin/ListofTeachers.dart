import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_school/services/database.dart'; // Import your DatabaseService
import 'package:flutter_school/Screens/Authentication/authenticate.dart';

class TeachersListScreen extends StatelessWidget {
  final Function(String, int) onStudentTap; // Updated to return teacher's name
  const TeachersListScreen({Key? key, required this.onStudentTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DatabaseService _database = DatabaseService();
    AuthService _authService = AuthService();

    User? user = _authService.getCurrentUser();

    return Scaffold(
      appBar: AppBar(
        title: Text('Teachers List'),
      ),
      body: FutureBuilder<List<String>>(
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
            List<String> teachersList = snapshot.data!;
            return ListView.builder(
              itemCount: teachersList.length,
              itemBuilder: (context, index) {
                String teacherName = teachersList[index];
                return ListTile(
                  leading: FutureBuilder<String>(
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
                    // Call the onTap function and pass the teacher's name
                    onStudentTap(teacherName, 5);
                    // Navigate to the teacher profile screen
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
