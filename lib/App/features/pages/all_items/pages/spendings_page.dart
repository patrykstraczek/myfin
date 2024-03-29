import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:myfin/App/core/enums.dart';
import 'package:myfin/App/domain/models/spendings_model.dart';
import 'package:myfin/App/features/pages/all_items/cubit/spendings/spendings_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:myfin/app/features/pages/home/pages/home_page.dart';
import 'package:myfin/app/core/currency_notifier.dart';
import 'package:myfin/app/injection_container.dart';
import 'package:provider/provider.dart';

class SpendingsPage extends StatelessWidget {
  const SpendingsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return getIt<SpendingsCubit>()..start();
        },
        child: BlocBuilder<SpendingsCubit, SpendingsState>(
          builder: (context, state) {
            switch (state.status) {
              case Status.initial:
                return const SizedBox.shrink();
              case Status.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case Status.success:
                return ListView(
                  children: [
                    for (final spending in state.docs)
                      _SpendingItemWidget(
                        model: spending,
                        isDarkMode: isDarkMode,
                      )
                  ],
                );
              case Status.error:
                return Center(
                  child: Text(
                    state.errorMessage ?? 'Unknown error',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}

class _SpendingItemWidget extends StatelessWidget {
  const _SpendingItemWidget(
      {Key? key, required this.model, required this.isDarkMode})
      : super(key: key);

  final SpendingsModel model;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    final currencyNotifier = Provider.of<CurrencyNotifier>(context);
    final selectedCurrency = currencyNotifier.selectedCurrency;
    return Dismissible(
      key: ValueKey(model.id),
      background: const DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.red,
        ),
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: 32.0),
            child: Icon(
              Icons.delete,
              color: Colors.black,
            ),
          ),
        ),
      ),
      confirmDismiss: (direction) async {
        return direction == DismissDirection.endToStart;
      },
      onDismissed: (direction) {
        context.read<SpendingsCubit>().remove(documentID: model.id);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 4.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            color: isDarkMode ? Colors.grey[900] : Colors.white,
          ),
          child: ListTile(
            dense: true,
            leading:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(
                IconData(model.selectedSpendingIcon,
                    fontFamily: 'materialIcons'),
              ),
            ]),
            title: Text(
              model.spendingName,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            subtitle: Text(
              DateFormat.yMMMEd(AppLocalizations.of(context).dateFormat)
                  .format(model.spendingDate),
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
            trailing: Text(
              '${model.spendingValue.toStringAsFixed(2)}  $selectedCurrency',
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
