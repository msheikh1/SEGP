import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Primary color for the application.
const myPrimaryColor = Color(0xFFFFB5A7);
// Light primary color for the application.
const myPrimaryLightColor = Color(0xFFFCD5CE);
// Background color for the application.
const myBackgroundColor = Color(0xFFFFFFFF);
// Dark blue color for the application.
const myDarkBlue = Color(0xFF003049);
// Red color for the application.
const myRed = Color(0xFFC1121F);
// Cream color for the application.
const myCream = Color(0xFFFDF0D5);

// Style for subheadings in the application.
TextStyle get subHeadingStyle{
  return GoogleFonts.montserrat (
    textStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold
    )
  );
}

// Style for titles in the application.
TextStyle get titleStyle {
  return GoogleFonts.montserrat (
    textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.black
    )
  );
}

// Style for subtitles in the application.
TextStyle get subTitleStyle {
  return GoogleFonts.montserrat (
    textStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.grey[400]
    )
  );
}