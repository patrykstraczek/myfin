import 'package:flutter/material.dart';
import 'package:myfin/app/domain/theme/theme_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  late ThemeData _themeData;

  ThemeProvider() {
    _themeData = lightTheme;
    _loadDarkModeState();
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

  Future<void> _loadDarkModeState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
    if (isDarkMode) {
      setDarkMode();
    } else {
      setLightMode();
    }
  }

  Future<void> saveDarkModeState(bool isDarkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDarkMode);
    notifyListeners();
  }
}
