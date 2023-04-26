import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CurrencyNotifier with ChangeNotifier {
  String _selectedCurrency = 'PLN'; // Domyślna wartość

  String get selectedCurrency => _selectedCurrency;

  Future<void> updateCurrency(String newCurrency) async {
    _selectedCurrency = newCurrency;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedCurrency', newCurrency);
  }

  Future<void> loadCurrency() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? loadedCurrency = prefs.getString('selectedCurrency');
    if (loadedCurrency != null) {
      _selectedCurrency = loadedCurrency;
      notifyListeners();
    }
  }
}