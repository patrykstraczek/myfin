import 'package:flutter/material.dart';
import 'package:myfin/App/features/pages/add/pages/add_page.dart';

class IconsBody extends StatelessWidget {
  const IconsBody({
    Key? key,
    this.icon,
    this.onTap,
    this.selected,
  }) : super(key: key);

  final IconData? icon;
  final VoidCallback? onTap;
  final bool? selected;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: selected ?? false
          ? InkWell(
              onTap: onTap,
              child: Icon(
                icon,
                color: spendingSelected ? Colors.red : Colors.green,
              ),
            )
          : InkWell(
              onTap: onTap,
              child: Icon(
                icon,
                color: Colors.grey,
              ),
            ),
    );
  }
}
