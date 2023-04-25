import 'package:flutter/material.dart';
import 'package:myfin/app/domain/theme/theme_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  late ThemeData _themeData;
  late bool _isDarkMode;

  ThemeProvider() {
    _themeData = lightTheme;
    _isDarkMode = false;
    _loadDarkModeState();
  }

  ThemeData getTheme() => _themeData;

  void setLightMode() {
    _themeData = lightTheme;
    _isDarkMode = false;
    notifyListeners();
  }

  void setDarkMode() {
    _themeData = darkTheme;
    _isDarkMode = true;
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
    _isDarkMode = isDarkMode;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDarkMode);
    notifyListeners();
  }
}
