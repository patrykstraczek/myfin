import 'package:flutter/material.dart';

bool darkMode = true;

IconData iconLight = Icons.wb_sunny;
IconData iconDark = Icons.nights_stay;

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.amber,
  brightness: Brightness.light,
  useMaterial3: true,
  colorScheme: const ColorScheme.highContrastLight(background: Colors.grey),
);

ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.amber,
  brightness: Brightness.dark,
  useMaterial3: true,
  colorScheme: const ColorScheme.highContrastDark(background: Colors.black),
);
