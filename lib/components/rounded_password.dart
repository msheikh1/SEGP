import 'package:flutter/material.dart';
import 'package:flutter_school/components/text_field_container.dart';

import '../constants.dart';

// This is a custom password field widget that is round in shape.
class RoundedPasswordField extends StatelessWidget {
  // The function to be executed when the password field value changes.
  final ValueChanged<String> onChanged;

  // Constructor for the RoundedPasswordField class.
  const RoundedPasswordField({
    super.key,
    required this.onChanged,
    required TextEditingController passwordController,
  });

  @override
  Widget build(BuildContext context) {
    // Return a TextFieldContainer widget that contains a TextField widget.
    return TextFieldContainer(
      child: TextField(
        // Set the text in the password field to be obscured.
        obscureText: true,
        // Set the function to be executed when the password field value changes.
        onChanged: onChanged,
        // Set the decoration for the password field.
        decoration: InputDecoration(
          // Set the hint text for the password field.
          hintText: "Password",
          // Set the icon for the password field.
          icon: Icon(
            Icons.lock,
            color: myDarkBlue,
          ),
          // Set the suffix icon for the password field.
          suffixIcon: Icon(
            Icons.visibility,
            color: myDarkBlue,
          ),
          // Remove the border for the password field.
          border: InputBorder.none,
        ),
      ),
    );
  }
}