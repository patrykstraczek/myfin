import 'package:flutter/material.dart';

class SpendingsIconsRepository {
  SpendingsIconsRepository();

  List<Map<String, dynamic>> spendingsItems = <Map<String, dynamic>>[
    <String, dynamic>{'icon': Icons.remove},
    <String, dynamic>{'icon': Icons.drive_eta},
    <String, dynamic>{'icon': Icons.food_bank},
    <String, dynamic>{'icon': Icons.home},
    <String, dynamic>{'icon': Icons.sports_esports},
  ];
}

class IncomesIconsRepository {
  IncomesIconsRepository();

  List<Map<String, dynamic>> incomesItems = <Map<String, dynamic>>[
    <String, dynamic>{'icon': Icons.add},
    <String, dynamic>{'icon': Icons.drive_eta},
    <String, dynamic>{'icon': Icons.food_bank},
    <String, dynamic>{'icon': Icons.home},
    <String, dynamic>{'icon': Icons.sports_esports},
  ];
}
