import 'package:flutter/material.dart';
import 'package:myfin/app/core/currency_notifier.dart';
import 'package:myfin/app/domain/theme/colors.dart';
import 'package:myfin/app/features/pages/home/pages/home_page.dart';
import 'package:provider/provider.dart';

class CurrencyButtons extends StatefulWidget {
  const CurrencyButtons({Key? key}) : super(key: key);

  @override
  State<CurrencyButtons> createState() => _CurrencyButtonsState();
}

class _CurrencyButtonsState extends State<CurrencyButtons> {
  late CurrencyNotifier currencyNotifier;
  List<bool> isSelected = [true, false, false];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currencyNotifier = Provider.of<CurrencyNotifier>(context);
    if (currencyNotifier.selectedCurrency == 'EUR') {
      isSelected = [false, true, false];
    } else if (currencyNotifier.selectedCurrency == 'USD') {
      isSelected = [false, false, true];
    } else {
      isSelected = [true, false, false];
    }
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      fillColor: isDarkMode ? Colors.black : Colors.white,
      selectedColor: accentColors(),
      isSelected: isSelected,
      onPressed: (int newIndex) {
        setState(() {
          for (int index = 0; index < isSelected.length; index++) {
            if (index == newIndex) {
              isSelected[index] = true;
              switch (index) {
                case 0:
                  currencyNotifier.updateCurrency('PLN');
                  break;
                case 1:
                  currencyNotifier.updateCurrency('EUR');
                  break;
                case 2:
                  currencyNotifier.updateCurrency('USD');
                  break;
              }
            } else {
              isSelected[index] = false;
            }
          }
        });
      },
      children: const [
        Text('PLN'),
        Text('EUR'),
        Text('USD'),
      ],
    );
  }
}
