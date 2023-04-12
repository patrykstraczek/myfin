import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:myfin/App/core/enums.dart';
import 'package:myfin/App/domain/models/incomes_model.dart';
import 'package:myfin/App/domain/models/spendings_model.dart';
import 'package:myfin/App/features/pages/all_items/cubit/spendings/spendings_cubit.dart';
import 'package:myfin/App/injection_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:myfin/App/features/pages/all_items/cubit/incomes/incomes_cubit.dart';
import 'package:myfin/app/domain/repositories/incomes_repository.dart';
import 'package:myfin/app/domain/repositories/spendings_repository.dart';
import 'package:myfin/app/features/pages/add/pages/add_page.dart';
import 'package:myfin/app/features/pages/details/cubit/details_cubit.dart';
import 'package:myfin/app/features/pages/home/pages/home_page.dart';
import 'package:myfin/app/widgets/floating_action_button.dart';

import 'package:myfin/App/domain/remote_data_sources/incomes_data_source.dart';
import 'package:myfin/App/domain/remote_data_sources/spending_data_source.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({
    Key? key,
    required this.selectedDay,
  }) : super(key: key);

  final DateTime selectedDay;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

int currentIndex = 0;

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: myFloatingActionButton(context),
      appBar: AppBar(
        title: Text(
            DateFormat.MMMMEEEEd(AppLocalizations.of(context).dateFormat)
                .format(widget.selectedDay)),
        centerTitle: true,
      ),
      body: Builder(builder: (context) {
        if (currentIndex == 0) {
          return SpendingsDetailsPage(
            selectedDay: widget.selectedDay,
          );
        }
        return IncomesDetailsPage(
          selectedDay: widget.selectedDay,
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor:
            isDarkMode ? const Color(0xff673ab7) : const Color(0xfff39c12),
        currentIndex: currentIndex,
        onTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.store),
            label: AppLocalizations.of(context).spendings,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.monetization_on),
            label: AppLocalizations.of(context).incomes,
          ),
        ],
      ),
    );
  }
}

class SpendingsDetailsPage extends StatelessWidget {
  const SpendingsDetailsPage({
    Key? key,
    required this.selectedDay,
  }) : super(key: key);

  final DateTime selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return DetailsCubit(
              SpendingsRepository(
                  firebaseSpendingsDataSource: FirebaseSpendingsDataSource()),
              IncomesRepository(
                  firebaseIncomeDataSource: FirebaseIncomeDataSource()))
            ..getDailyStream(selectedDay: selectedDay);
        },
        child: BlocBuilder<DetailsCubit, DetailsState>(
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
                return ListView(
                  children: [
                    for (final spending in state.spendingDocs)
                      _SpendingDetailsItemWidget(
                          model: spending,
                          isDarkMode: isDarkMode,
                          selectedDay: selectedDay)
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

class _SpendingDetailsItemWidget extends StatefulWidget {
  const _SpendingDetailsItemWidget({
    Key? key,
    required this.model,
    required this.isDarkMode,
    required this.selectedDay,
  }) : super(key: key);

  final SpendingsModel model;
  final bool isDarkMode;

  final DateTime selectedDay;

  @override
  State<_SpendingDetailsItemWidget> createState() =>
      _SpendingDetailsItemWidgetState();
}

class _SpendingDetailsItemWidgetState
    extends State<_SpendingDetailsItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.model.id),
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
        context.read<SpendingsCubit>().remove(documentID: widget.model.id);
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
                IconData(widget.model.selectedSpendingIcon,
                    fontFamily: 'materialIcons'),
              ),
            ]),
            title: Text(
              widget.model.spendingName,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            trailing: Text(
              '${widget.model.spendingValue}  PLN',
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

class IncomesDetailsPage extends StatelessWidget {
  const IncomesDetailsPage({
    Key? key,
    required this.selectedDay,
  }) : super(key: key);

  final DateTime selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return DetailsCubit(
              SpendingsRepository(
                  firebaseSpendingsDataSource: FirebaseSpendingsDataSource()),
              IncomesRepository(
                  firebaseIncomeDataSource: FirebaseIncomeDataSource()))
            ..getDailyStream(selectedDay: selectedDay);
        },
        child: BlocBuilder<DetailsCubit, DetailsState>(
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
                  for (final income in state.incomesDocs)
                    _IncomeDetailsItemWidget(
                        model: income,
                        isDarkMode: isDarkMode,
                        selectedDay: selectedDay)
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

class _IncomeDetailsItemWidget extends StatelessWidget {
  const _IncomeDetailsItemWidget(
      {Key? key,
      required this.model,
      required this.isDarkMode,
      required this.selectedDay})
      : super(key: key);

  final IncomesModel model;
  final bool isDarkMode;
  final DateTime selectedDay;

  @override
  Widget build(BuildContext context) {
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
            trailing: Text(
              '${model.incomeValue}  PLN',
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
