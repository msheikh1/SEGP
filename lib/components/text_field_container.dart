import 'package:flutter/material.dart';

import '../constants.dart';

// This is a custom container widget for text fields.
class TextFieldContainer extends StatelessWidget {
  // The child widget to be displayed inside the container.
  final Widget child;

  // Constructor for the TextFieldContainer class.
  const TextFieldContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // Get the size of the screen.
    Size size = MediaQuery.of(context).size;
    // Return a Container widget that contains the child widget.
    return Container(
      // Set the margin for the container.
      margin: EdgeInsets.symmetric(vertical: 10),
      // Set the padding for the container.
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      // Set the width of the container.
      width: size.width * 0.8,
      // Set the decoration for the container.
      decoration: BoxDecoration(
        // Set the color for the container.
        color: myLightBlue,
        // Set the border radius for the container.
        borderRadius: BorderRadius.circular(29),
      ),
      // Set the child widget for the container.
      child: child,
    );
  }
}