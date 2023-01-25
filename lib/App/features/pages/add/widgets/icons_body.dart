import 'package:flutter/material.dart';

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
                color: Colors.amber,
                
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
