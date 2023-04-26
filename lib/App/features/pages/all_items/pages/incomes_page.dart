import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:myfin/App/core/enums.dart';
import 'package:myfin/App/domain/models/incomes_model.dart';
import 'package:myfin/App/features/pages/all_items/cubit/incomes/incomes_cubit.dart';
import 'package:myfin/App/injection_container.dart';
import 'package:myfin/app/features/pages/add/widgets/currency_buttons.dart';
import 'package:myfin/app/features/pages/home/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:myfin/app/core/currency_notifier.dart';

class IncomesPage extends StatelessWidget {
  const IncomesPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return getIt<IncomesCubit>()..start();
        },
        child: BlocBuilder<IncomesCubit, IncomesState>(
          builder: (context, state) {
            switch (state.status) {
              case Status.initial:
                return const Center(
                  child: Text(''),
                );
              case Status.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );

              case Status.success:
                return ListView(children: [
                  for (final income in state.docs)
                    _IncomeItemWidget(model: income, isDarkMode: isDarkMode)
                ]);
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

class _IncomeItemWidget extends StatelessWidget {
  const _IncomeItemWidget(
      {Key? key, required this.model, required this.isDarkMode})
      : super(key: key);

  final IncomesModel model;
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
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 32.0),
            child: Icon(
              Icons.delete,
              color: Colors.black,
            ),
          ),
        ),
      ),
      confirmDismiss: (direction) async {
        return direction == DismissDirection.startToEnd;
      },
      onDismissed: (direction) {
        context.read<IncomesCubit>().remove(documentID: model.id);
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
                IconData(model.selectedIncomesIcon,
                    fontFamily: 'materialIcons'),
              ),
            ]),
            title: Text(
              model.incomeName,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            subtitle: Text(
              DateFormat.yMMMEd(AppLocalizations.of(context).dateFormat)
                  .format(model.incomeDate),
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
            trailing: Text(
              '${model.incomeValue}  $selectedCurrency',
              style: const TextStyle(
                color: Colors.green,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
