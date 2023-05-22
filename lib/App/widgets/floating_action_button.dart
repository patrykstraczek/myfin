import 'package:flutter/material.dart';
import 'package:myfin/App/features/pages/add/pages/add_page.dart';
import 'package:myfin/app/domain/theme/colors.dart';

class MyFloatingActionButton extends StatelessWidget {
  const MyFloatingActionButton({
    Key? key,
    required this.isDarkMode,
  }) : super(key: key);

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: isDarkMode ? Colors.white12 : Colors.white,
      foregroundColor: accentColors(),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) => const AddPage(),
        ));
      },
      child: const Icon(Icons.add),
    );
  }
}
