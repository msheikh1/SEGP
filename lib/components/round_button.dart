import 'package:flutter/material.dart';
import 'package:flutter_school/constants.dart';

// This is a custom button widget that is round in shape.
class RoundButton extends StatelessWidget {
  // The text to be displayed on the button.
  final String text;
  // The function to be executed when the button is pressed.
  final Function press;
  // The color of the button.
  final Color color;
  // The color of the text on the button.
  final Color textColor;

  // Constructor for the RoundButton class.
  const RoundButton(
      {super.key,
      required this.text,
      required this.press,
      this.color = myDarkBlue,
      this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    // Get the size of the screen.
    Size size = MediaQuery.of(context).size;
    return Container(
      // Set the margin for the button.
      margin: EdgeInsets.symmetric(vertical: 8),
      // Set the width of the button.
      width: size.width * 0.7,
      child: ClipRRect(
        // Set the border radius for the button.
        borderRadius: BorderRadius.circular(29),
        child: TextButton(
          // Set the style for the button.
          style: TextButton.styleFrom(
              backgroundColor: color,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40)),
          // Set the function to be executed when the button is pressed.
          onPressed: () {
            press();
          },
          // Set the text for the button.
          child: Text(text, style: TextStyle(color: myCream)),
        ),
      ),
    );
  }
}