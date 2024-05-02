// Import necessary packages
import 'package:flutter/material.dart';
import 'package:flutter_school/Screens/Welcome/components/body.dart';

// WelcomeScreen is a stateless widget that displays the welcome screen
class WelcomeScreen extends StatelessWidget {
  // Constructor
  const WelcomeScreen({super.key});

  // Build method
  @override
  Widget build(BuildContext context) {
    // Return a Scaffold widget with the Body widget as its body
    return const Scaffold(
      body: Body(),
    );
  }
}