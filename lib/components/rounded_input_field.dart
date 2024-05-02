import 'package:flutter/material.dart';
import 'package:flutter_school/components/text_field_container.dart';

import '../constants.dart';

// This is a custom input field widget that is round in shape.
class RoundedInputField extends StatelessWidget {
  // The hint text to be displayed in the input field.
  final String hintText;
  // The icon to be displayed in the input field.
  final IconData icon;
  // The function to be executed when the input field value changes.
  final ValueChanged<String> onChanged;

  // Constructor for the RoundedInputField class.
  const RoundedInputField({
    super.key,
    required TextEditingController emailController,
    required this.hintText,
    this.icon = Icons.person,
    required this.onChanged,
  }) : _emailController = emailController;

  // The controller for the input field.
  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    // Return a TextFieldContainer widget that contains a TextField widget.
    return TextFieldContainer(
      child: TextField(
        // Set the function to be executed when the input field value changes.
        onChanged: onChanged,
        // Set the controller for the input field.
        controller: _emailController,
        // Set the decoration for the input field.
        decoration: InputDecoration(
          // Set the icon for the input field.
          icon: Icon(
            icon,
            color: myDarkBlue,
          ),
          // Set the hint text for the input field.
          hintText: hintText,
          // Remove the border for the input field.
          border: InputBorder.none
        ),
      ),
    );
  }
}