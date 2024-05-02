// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_school/Screens/Authentication/authenticate.dart';
// import 'package:flutter_school/services/database.dart';
//
// class RegistrationScreen extends StatefulWidget {
//   @override
//   _RegistrationScreenState createState() => _RegistrationScreenState();
// }
//
// class _RegistrationScreenState extends State<RegistrationScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final AuthService authService = AuthService();
//   final DatabaseService database = DatabaseService();
//   final TextEditingController _emailController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _nameController = TextEditingController();
//
//   Future<void> _register() async {
//     try {
//       final String name = _nameController.text.trim();
//       // Await the registration operation to complete
//       UserCredential? userCredential = await authService.register(
//           _emailController.text, _passwordController.text, name);
//
//       if (userCredential != null) {
//         // If registration was successful, save user to Firestore
//         database.saveNewUser(userCredential, name, email, userType, district, school, childrenNames)
//         // Navigate to the next screen after successful registration
//         Navigator.pushReplacementNamed(context, '/teacher');
//       } else {
//         // Handle case where registration failed
//         throw Exception('User registration failed');
//       }
//     } catch (e) {
//       // Handle registration errors here
//       print('Registration failed: $e');
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Registration Failed'),
//             content: Text(
//                 'An error occurred during registration. Please try again.'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Registration'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               controller: _nameController,
//               decoration: InputDecoration(labelText: 'Name'),
//             ),
//             SizedBox(height: 8.0),
//             TextField(
//               controller: _emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//               keyboardType: TextInputType.emailAddress,
//             ),
//             SizedBox(height: 16.0),
//             TextField(
//               controller: _passwordController,
//               decoration: InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: _register,
//               child: Text('Register'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
