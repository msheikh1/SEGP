import 'package:flutter/material.dart';
import 'package:flutter_school/components/text_field_container.dart';

import '../constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;

  const RoundedInputField({
    super.key,
    required TextEditingController emailController,
    required this.hintText,
    this.icon = Icons.person,
    required this.onChanged,
  }) : _emailController = emailController;

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        controller: _emailController,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: myDarkBlue,
          ),
          hintText: hintText, border: InputBorder.none
        ),
      ),
    );
  }
}