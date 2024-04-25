import 'package:flutter/material.dart';
import 'package:flutter_school/components/text_field_container.dart';

import '../constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    super.key, required this.onChanged,
    required TextEditingController passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: myDarkBlue,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: myDarkBlue,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}