import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const myPrimaryColor = Color(0xFFFFB5A7);
const myPrimaryLightColor = Color(0xFFFCD5CE);
const myBackgroundColor = Color(0xFFFFFFFF);
const myDarkBlue = Color(0xFF003049);
const myRed = Color(0xFFC1121F);
const myCream = Color(0xFFFDF0D5);



TextStyle get subHeadingStyle{
  return GoogleFonts.montserrat (
    textStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold
    )
  );
}

TextStyle get titleStyle {
  return GoogleFonts.montserrat (
    textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.black
    )
  );
}

TextStyle get subTitleStyle {
  return GoogleFonts.montserrat (
    textStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.grey[400]
    )
  );
}