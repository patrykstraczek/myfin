import 'package:flutter/material.dart';

bool darkMode = true;

IconData iconLight = Icons.wb_sunny;
IconData iconDark = Icons.nights_stay;

final lightTheme = ThemeData(
  primarySwatch: Colors.amber,
  brightness: Brightness.light,
  useMaterial3: true,
  colorScheme:
      const ColorScheme.highContrastLight(background: Color(0xffe5e5e5)),
  appBarTheme: const AppBarTheme(
    surfaceTintColor: Color(0xffe5e5e5),
    backgroundColor: Color(0xffe5e5e5),
  ),
);

final darkTheme = ThemeData(
  primarySwatch: Colors.amber,
  brightness: Brightness.dark,
  useMaterial3: true,
  colorScheme: const ColorScheme.highContrastDark(background: Colors.black),
  appBarTheme: const AppBarTheme(
    surfaceTintColor: Colors.black,
    backgroundColor: Colors.black,
  ),
);
