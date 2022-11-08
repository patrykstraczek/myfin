import 'package:flutter/material.dart';

bool darkMode = true;

IconData iconLight = Icons.wb_sunny;
IconData iconDark = Icons.nights_stay;

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.amber,
  brightness: Brightness.light,
  bottomAppBarColor: Colors.amber,
  splashColor: Colors.amber,
  selectedRowColor: Colors.amber,
  backgroundColor: Colors.grey[200],
  buttonColor: Colors.amber,
  scaffoldBackgroundColor: Colors.grey[200],
);

ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.amber,
    brightness: Brightness.dark,
    bottomAppBarColor: Colors.amber,
    highlightColor: Colors.amber,
    selectedRowColor: Colors.amber,
    backgroundColor: Colors.black,
    buttonColor: Colors.amber,
    scaffoldBackgroundColor: Colors.black,
    hintColor: Colors.amber);
