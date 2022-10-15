import 'package:flutter/material.dart';

bool iconBool = true;

IconData iconLight = Icons.wb_sunny;
IconData iconDark = Icons.nights_stay;

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.amber,
  brightness: Brightness.light,
  bottomAppBarColor: Colors.amber,
  splashColor: Colors.amber,
  selectedRowColor: Colors.amber,
  backgroundColor: Colors.black,
  buttonColor: Colors.amber,
  scaffoldBackgroundColor: Colors.white,
);

ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.amber,
  brightness: Brightness.dark,
  bottomAppBarColor: Colors.amber,
  splashColor: Colors.amber,
  selectedRowColor: Colors.amber,
  backgroundColor: Colors.black,
  buttonColor: Colors.amber,
  scaffoldBackgroundColor: Colors.black,
);
