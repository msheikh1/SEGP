import 'package:flutter/cupertino.dart';
import 'package:flutter_school/constants.dart';

// MyButton is a stateless widget that displays a button
class MyButton extends StatelessWidget {
  // label is the text displayed on the button
  // onTap is the function that is called when the button is tapped
  final String label;
  final Function()? onTap;

  // Constructor
  const MyButton({super.key, required this.label, required this.onTap});

  // Build method
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Call the onTap function when the button is tapped
      onTap: onTap,
      child: Container(
        // Set the width and height of the button
        width: 115,
        height: 50,
        // Set the decoration of the button
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: myDarkBlue,
        ),
        child: Center(
          // Display the label text in the center of the button
          child: Text(
            label,
            style: TextStyle(
              color: myCream,
            )
          ),
        ),
      ),
    );
  }
}