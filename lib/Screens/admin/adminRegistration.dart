import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_school/Screens/Authetication/authenticate.dart';
import 'package:flutter_school/services/database.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService authService = AuthService();
  final DatabaseService database = DatabaseService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  String _selectedUserType = 'Parent'; // Default user type
  String _selectedDistrict = 'District1'; // Default district
  String _selectedSchool = 'School1'; // Default school
  List<String> _districts = ['District1', 'District4', 'District6'];
  Map<String, List<String>> _schools = {
    'District1': ['School1', 'School2', 'School3'],
    'District4': ['School4', 'School5'],
    'District6': ['School6', 'School7', 'School8'],
  };

  List<String> _childrenNames = ['']; // List to store children's names
  int _childrenCount = 1;

  @override
  void initState() {
    super.initState();
    _passwordController.text = "123456"; // Set default password
    _passwordController.addListener(() {
      // Ensure that the password remains constant
      if (_passwordController.text != "123456") {
        _passwordController.text = "123456";
      }
      _passwordController.selection = TextSelection.fromPosition(
          TextPosition(offset: _passwordController.text.length));
    });
  }

  Future<void> _register() async {
    try {
      final String name = _nameController.text.trim();
      final String email = _emailController.text.trim();
      final String userType = _selectedUserType;
      final String district = _selectedDistrict;
      final String school = _selectedSchool;

      // Collect children names only if user type is 'Parent'
      final List<String> childrenNames = _selectedUserType == 'Parent'
          ? _childrenNames.where((name) => name.isNotEmpty).toList()
          : [];

      // Await the registration operation to complete
      UserCredential? userCredential =
          await authService.register(email, _passwordController.text, name);

      if (userCredential != null) {
        // If registration was successful, save user to Firestore
        await database.saveNewUser(userCredential, name, email, userType,
            district, school, childrenNames);
        // Navigate to the next screen after successful registration
        Navigator.pushReplacementNamed(context, '/teacher');
      } else {
        // Handle case where registration failed
        throw Exception('User registration failed');
      }
    } catch (e) {
      // Handle registration errors here
      print('Registration failed: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Registration Failed'),
            content: Text(
                'An error occurred during registration. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 8.0),
            DropdownButtonFormField<String>(
              value: _selectedUserType,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedUserType = newValue!;
                });
              },
              items: <String>['Parent', 'Teacher', 'Admin']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'User Type',
              ),
            ),
            SizedBox(height: 8.0),
            if (_selectedUserType == 'Parent') ...[
              ListView.builder(
                shrinkWrap: true,
                itemCount: _childrenCount,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Child ${index + 1}',
                        hintText: 'Enter child\'s name',
                      ),
                      onChanged: (value) {
                        _childrenNames[index] = value;
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _childrenCount++;
                    _childrenNames.add('');
                  });
                },
                child: Text('Add Child'),
              ),
              SizedBox(height: 8.0),
            ],
            if (_selectedUserType == 'Teacher') ...[
              DropdownButtonFormField<String>(
                value: _selectedDistrict,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedDistrict = newValue!;
                    _selectedSchool = _schools[newValue]![0];
                  });
                },
                items: _districts.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'District',
                ),
              ),
              SizedBox(height: 8.0),
              DropdownButtonFormField<String>(
                value: _selectedSchool,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedSchool = newValue!;
                  });
                },
                items: _schools[_selectedDistrict]!
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'School',
                ),
              ),
              SizedBox(height: 8.0),
            ],
            ElevatedButton(
              onPressed: _register,
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
