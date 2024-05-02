import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// AppText is a stateless widget that displays a text
class AppText extends StatelessWidget {
  // size is the font size of the text, default is 16
  // text is the content of the text
  // color is the color of the text, default is black54
  double size;
  final String text;
  final Color color;
  AppText({super.key,
    this.size = 16,
    required this.text,
    this.color=Colors.black54}
      );

  @override
  Widget build(BuildContext context) {
    return Text(
        text,
        style: TextStyle (
            color:color,
            fontSize: size,
        )
    );
  }
}