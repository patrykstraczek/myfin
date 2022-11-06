import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyCalendar extends StatelessWidget {
  const MyCalendar({
    Key? key,
    required this.onDateChanged,
    this.selectedDateFormatted,
  }) : super(key: key);

  final Function(DateTime?) onDateChanged;
  final String? selectedDateFormatted;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          final selectedDate = await showDatePicker(
              currentDate: DateTime.now(),
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now().subtract(
                const Duration(days: 365),
              ),
              lastDate: DateTime.now());
          onDateChanged(selectedDate);
        },
        child: Text(selectedDateFormatted ??
            DateFormat.yMMMEd().format(DateTime.now())));
  }
}
