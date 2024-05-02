import 'package:flutter/material.dart';

// Background is a stateless widget that displays a background with a child widget
class Background extends StatelessWidget {
  // child is a required parameter
  final Widget child;

  // Constructor
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  // Build method
  @override
  Widget build(BuildContext context) {
    // Get the size of the screen
    Size size = MediaQuery.of(context).size;

    return Container(
        // Set the height and width to fill the screen
        height: size.height,
        width: double.infinity,
        child: Stack(
          // Center the child widget
          alignment: Alignment.center,
          children: <Widget>[
            // Position the top wave image at the top of the screen
            Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/wave_blue_top.png",
                  width: size.width,
                )),
            // Position the bottom wave image at the bottom of the screen
            Positioned(
                bottom: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/wave_blue_bottom.png",
                  width: size.width,
                )),
            // Add the child widget
            child,
          ],
        ));
  }
}