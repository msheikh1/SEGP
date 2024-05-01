import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// TextInputWidget is a stateless widget that displays a text input field
class TextInputWidget extends StatelessWidget {
  // hintText is the hint text displayed in the input field
  // maxLine is the maximum number of lines the input field can expand to accommodate
  // txtController is the controller for the input field
  final String hintText;
  final int maxLine;
  final TextEditingController txtController;

  // Constructor
  const TextInputWidget({
    super.key,
    required this.hintText,
    required this.maxLine,
    required this.txtController,
  });

  // Build method
  @override
  Widget build(BuildContext context) {
    return Container(
      // Set the padding of the container
      padding: EdgeInsets.symmetric(horizontal: 20),
      // Set the decoration of the container
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(8)),
      child: TextField(
        // Set the controller of the TextField
        controller: txtController,
        // Set the decoration of the TextField
        decoration: InputDecoration(
            // Remove the border of the TextField
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            // Set the hint text and its style
            hintText: hintText,
            hintStyle: TextStyle(fontWeight: FontWeight.w400)),
        // Set the maximum number of lines the TextField can expand to accommodate
        maxLines: maxLine,
      ),
    );
  }
}