import 'package:flutter/material.dart';
import 'package:myfin/app/core/currency_notifier.dart';
import 'package:provider/provider.dart';




class CurrencyButtons extends StatefulWidget {
  const CurrencyButtons({Key? key}) : super(key: key);

  @override
  State<CurrencyButtons> createState() => _CurrencyButtonsState();
}

class _CurrencyButtonsState extends State<CurrencyButtons> {
  String selectedCurrency = 'PLN';
  List<bool> isSelected = [true, false, false];

  @override
  Widget build(BuildContext context) {
    final currencyNotifier = Provider.of<CurrencyNotifier>(context);
    return ToggleButtons(
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
