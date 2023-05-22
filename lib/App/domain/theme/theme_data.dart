import 'package:flutter/material.dart';

bool darkMode = true;

IconData iconLight = Icons.wb_sunny;
IconData iconDark = Icons.nights_stay;

final lightTheme = ThemeData(
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
  brightness: Brightness.dark,
  useMaterial3: true,
  colorScheme: const ColorScheme.highContrastDark(background: Colors.black),
  appBarTheme: const AppBarTheme(
    surfaceTintColor: Colors.black,
    backgroundColor: Colors.black,
  ),
);

ThemeData dialogTheme(bool isDarkMode) {
  return isDarkMode
      ? ThemeData(
          colorScheme: const ColorScheme.dark(
            primary: Color(0xff673ab7), // header background color
            onPrimary: Colors.white, // header text color
            onSurface: Colors.white, // body text color
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white, // button text color
            ),
          ),
          dialogBackgroundColor: Colors.black,
          buttonTheme:
              const ButtonThemeData(textTheme: ButtonTextTheme.primary),
        )
      : ThemeData(
          colorScheme: const ColorScheme.light(
            primary: Color(0xfff5b041),
            onPrimary: Colors.black,
            onSurface: Colors.black,
          ),
          dialogBackgroundColor: Colors.white,
          buttonTheme:
              const ButtonThemeData(textTheme: ButtonTextTheme.primary),
        );
}
