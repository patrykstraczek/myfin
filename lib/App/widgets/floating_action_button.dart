import 'package:flutter/material.dart';
import 'package:myfin/App/features/pages/add/pages/add_page.dart';

FloatingActionButton myFloatingActionButton(BuildContext context) {
  return FloatingActionButton(
    backgroundColor: Colors.grey[300],
    foregroundColor: Colors.black,
    onPressed: () {
      Navigator.of(context).push(MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => const AddPage(),
      ));
    },
    child: const Icon(Icons.add),
  );
}
