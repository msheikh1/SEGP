// Import necessary packages
import 'package:flutter/material.dart';
import 'package:flutter_school/Screens/Authentication/authenticate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_school/services/database.dart';

// LoginPage is a stateful widget that displays the login interface
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controllers for the email and password input fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Instances of auth and database services
  final AuthService _auth = AuthService();
  final DatabaseService _databaseService = DatabaseService();

  // Function to sign in with email and password
  void _signInWithEmailAndPassword() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text;

    // Sign in with email and password
    final User? user = await _auth.signInWithEmailAndPassword(email, password);

    if (user != null) {
      // If the user is signed in, navigate to the appropriate screen based on the user type
      print('User logged in: ${user.email}');
      String? Type = await _databaseService.getUserType(user);
      print("Type value:" + Type!);
      String currentType = "";
      if (Type != null) {
        currentType = Type;
      }
      print("Login Type: " + currentType);
      if (currentType == "teacher") {
        Navigator.pushNamed(context, '/teacher');
      } else {
        if (currentType == "parent") {
          Navigator.pushNamed(context, '/parent');
        } else {
          Navigator.pushNamed(context, '/admin');
        }
      }
    } else {
      // If the user is not signed in, show an error message
      print('Failed to sign in');
    }
  }

  // Build method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Email input field
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 8.0),
            // Password input field
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            // Login button
            ElevatedButton(
              onPressed: _signInWithEmailAndPassword,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}