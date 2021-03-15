import 'package:flutter/material.dart';
import 'package:flutter_social/view/my_widgets/constants.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    // fontFamily: "Muli",
    fontFamily: GoogleFonts.comfortaa().fontFamily,
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide.none,
    gapPadding: 10.0,
  );
  return InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 35),
    focusedBorder: outlineInputBorder,
    enabledBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}

TextTheme textTheme() {
  return TextTheme(
    bodyText1: TextStyle(color: lPrimaryColor),
    bodyText2: TextStyle(color: lPrimaryColor),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    elevation: 0,
    color: Colors.white,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.black),
    textTheme: TextTheme(headline6: TextStyle(color: Colors.black, fontSize: 18)),
  );
}
