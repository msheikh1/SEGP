import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// AppLargeText is a stateless widget that displays a large text
class AppLargeText extends StatelessWidget {
  // size is the font size of the text, default is 26
  // text is the content of the text
  // color is the color of the text, default is black
  final double size;
  final String text;
  final Color color;

  // Constructor
  AppLargeText({
    super.key,
    this.size = 26,
    required this.text,
    this.color = Colors.black,
  });

  // Build method
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}