import 'package:flutter/material.dart';
import 'package:flutter_school/Screens/Authentication/authenticate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_school/services/database.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DatabaseService _databaseService = DatabaseService();

  final AuthService _auth = AuthService();

  void _signInWithEmailAndPassword() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text;

    final User? user = await _auth.signInWithEmailAndPassword(email, password);

    if (user != null) {
      // Navigate to home screen or do something else
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
      // Show error message or handle sign-in failure
      print('Failed to sign in');
    }
  }

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
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
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
