import 'package:flutter/material.dart';
import 'package:flutter_school/constants.dart';

class RoundButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const RoundButton(
      {super.key,
      required this.text,
      required this.press,
      this.color = myPrimaryColor,
      this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      width: size.width * 0.7,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: color,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40)),
          onPressed: () {},
          child: Text(text, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
