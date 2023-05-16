import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:myfin/app/domain/theme/theme_data.dart';

import 'package:myfin/app/features/pages/home/pages/home_page.dart';

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
          lastDate: DateTime.now(),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: datePickerTheme(isDarkMode),
              child: child ?? Container(),
            );
          },
        );
        onDateChanged(selectedDate);
      },
      child: Text(
        selectedDateFormatted ??
            DateFormat.yMMMEd(AppLocalizations.of(context).dateFormat).format(
              DateTime.now(),
            ),
        style: TextStyle(
          color: isDarkMode ? Colors.white : const Color(0xfff39c12),
        ),
      ),
    );
  }
}
