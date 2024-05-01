import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_school/Screens/Authentication/authenticate.dart';
import 'package:flutter_school/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_school/services/database.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_school/constants.dart';

class ProfileScreen extends StatefulWidget {
  final Function(int) onStudentTap;
  const ProfileScreen({
    Key? key,
    required this.onStudentTap,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final DatabaseService _database = DatabaseService();
  final AuthService _auth = AuthService();

  String _name = '';
  String _email = '';
  String _profileImageUrl = ''; // To store profile image URL
  File? image;
  late User users;

  final ImagePicker _picker = ImagePicker();

  Future pickImage(ImageSource? source) async {
    final XFile? pickedImage = await _picker.pickImage(source: source!);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
      // Upload image to Firebase Storage and update user profile
      uploadImageAndSetProfile(pickedImage.path);
    } else {
      print("No image selected");
    }
  }

  Future<void> _loadUserData() async {
    final User? user = _auth.getCurrentUser();

    if (user != null) {
      users = user;
      final String name = await _database.getUserName(user) ?? '';
      final String email = user.email ?? "Unknown Email";
      final String profileImageUrl = await _database
          .getUserProfileImageUrl(user); // Fetch profile image URL
      setState(() {
        _name = name;
        _email = email;
        _profileImageUrl = profileImageUrl;
      });
    }
  }

  Future<void> uploadImageAndSetProfile(String imagePath) async {
    final User? user = _auth.getCurrentUser();
    if (user != null) {
      // Upload image to Firebase Storage
      String imageUrl = await _database.uploadUserProfileImage(user, imagePath);
      // Update user profile with the image URL
      await _database.setUserProfileImageUrl(user, imageUrl);
      // Update UI with new image URL
      setState(() {
        _profileImageUrl = imageUrl;
      });
    }
  }

  Future<void> _logout() async {
    try {
      await _auth.signOut(); // Call the signOut method from AuthService
      // Navigate to the authentication screen after logout
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomeScreen(),
        ),
      );
      Get.offAll(() => AuthService());
    } catch (error) {
      print('Error signing out: $error');
      // Handle any errors that occur during logout
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 54,
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        pickImage(ImageSource.gallery);
                      },
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 48,
                            backgroundImage: _profileImageUrl.isNotEmpty
                                ? NetworkImage(_profileImageUrl)
                                : AssetImage('assets/profile.png')
                                    as ImageProvider,
                            child: _profileImageUrl.isEmpty
                                ? Image.asset(
                                    'assets/profile.png',
                                    fit: BoxFit.cover,
                                  )
                                : SizedBox.shrink(),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 5,
                            child: Container(
                              height: 26,
                              width: 26,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.grey,
                                border:
                                    Border.all(color: Colors.white, width: 1),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                  size: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      _name.isEmpty ? 'Loading...' : _name,
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 32),
                    ),
                    const SizedBox(
                      height: 0,
                    ),
                    const Text(
                      'Email',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    Text(
                      _email.isEmpty ? 'Loading...' : _email,
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            _customButton(
                              title: "Change Password",
                              onPressed: () {
                                _database.resetPassword(_email);
                                // Show a pop-up message
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Password Reset Email Sent'),
                                      content: Text(
                                          'A password reset email has been sent to $_email.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Close the dialog
                                          },
                                          child: Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            _customButton(
                              title: "Log Out",
                              onPressed: _logout,
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _customButton({
    required String title,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: 44,
      width: 240,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: myDarkBlue,
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: myCream,
          ),
        ),
      ),
    );
  }
}
