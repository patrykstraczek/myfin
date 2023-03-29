import 'package:flutter/material.dart';
import 'package:myfin/App/features/pages/add/pages/add_page.dart';
import 'package:myfin/app/features/pages/home/pages/home_page.dart';

FloatingActionButton myFloatingActionButton(BuildContext context) {
  return FloatingActionButton(
    backgroundColor: isDarkMode ? Colors.white12 : Colors.grey[300],
    foregroundColor:
        isDarkMode ? const Color(0xff673ab7) : const Color(0xfff5b041),
    onPressed: () {
      Navigator.of(context).push(MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => const AddPage(),
      ));
    },
    child: const Icon(Icons.add),
  );
}
