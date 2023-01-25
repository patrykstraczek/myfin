import 'package:flutter/material.dart';

bool darkMode = true;

IconData iconLight = Icons.wb_sunny;
IconData iconDark = Icons.nights_stay;

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  splashColor: Colors.amber,
  scaffoldBackgroundColor: Colors.grey[200],
  bottomAppBarTheme: const BottomAppBarTheme(color: Colors.amber),
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber).copyWith(
    background: Colors.grey[200],
    brightness: Brightness.light,
  ),
);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  highlightColor: Colors.amber,
  scaffoldBackgroundColor: Colors.black,
  hintColor: Colors.amber,
  bottomAppBarTheme: const BottomAppBarTheme(color: Colors.amber),
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber).copyWith(
    background: Colors.black,
    brightness: Brightness.dark,
  ),
);
