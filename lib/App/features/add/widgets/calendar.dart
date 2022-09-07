import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyCalendar extends StatelessWidget {
  const MyCalendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime actualDate = DateTime.now();

    return ElevatedButton(
      onPressed: () async {
        await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(
              const Duration(days: 365),
            ),
            lastDate: DateTime.now());
      },
      child: Text(DateFormat.yMMMEd().format(actualDate)),
    );
  }
}
