import 'package:flutter/material.dart';
import 'package:myfin/app/domain/theme/theme_data.dart';


class ThemeProvider with ChangeNotifier {
  late ThemeData _themeData;

  ThemeProvider() {
    _themeData = lightTheme;
  }

  ThemeData getTheme() => _themeData;

  void setLightMode() {
    _themeData = lightTheme;
    notifyListeners();
  }

  void setDarkMode() {
    _themeData = darkTheme;
    notifyListeners();
  }
}