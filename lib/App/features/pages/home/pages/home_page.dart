import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:myfin/App/core/enums.dart';
import 'package:myfin/App/domain/remote_data_sources/incomes_data_source.dart';
import 'package:myfin/App/domain/remote_data_sources/spending_data_source.dart';
import 'package:myfin/app/domain/repositories/incomes_repository.dart';
import 'package:myfin/app/domain/repositories/spendings_repository.dart';
import 'package:myfin/app/domain/theme/theme_provider.dart';
import 'package:myfin/App/features/pages/all_items/pages/all_items_page.dart';
import 'package:myfin/app/features/pages/home/cubit/home_cubit.dart';
import 'package:myfin/app/features/pages/daily/daily_reports_page.dart';
import 'package:myfin/app/injection_container.dart';
import 'package:myfin/app/widgets/drawer_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:myfin/app/widgets/floating_action_button.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

DateTime? date;
bool isDarkMode = true;
double spendingsInMonth = 0.0;
double incomeInMonth = 0.0;

class _HomePageState extends State<HomePage> {
  late int startYear;
  static const int december = 12;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();

    startYear = now.year;
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final currentYear = today.year;
    final currentMonth = today.month;

    final months = List<int>.generate(currentMonth, (i) => i + 1)
        .toList()
        .reversed
        .toList();

    if (startYear < currentYear) {
      months.addAll(List<int>.generate(december, (i) => i + 1));
    }

    return Scaffold(
      drawer: DrawerWidget(isDarkMode: isDarkMode),
      appBar: AppBar(
        surfaceTintColor: isDarkMode ? Colors.grey[900] : Colors.white,
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
        title: const Text('Podsumowania'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: isDarkMode
                ? const Icon(Icons.nights_stay)
                : const Icon(Icons.wb_sunny),
            onPressed: () {
              setState(() {
                isDarkMode = !isDarkMode;
              });
              if (isDarkMode) {
                // switch to dark theme
                Provider.of<ThemeProvider>(context, listen: false)
                    .setDarkMode();
              } else {
                // switch to light theme
                Provider.of<ThemeProvider>(context, listen: false)
                    .setLightMode();
              }
            },
          ),
        ],
      ),
      floatingActionButton: myFloatingActionButton(context),
      body: Column(children: [
        _AllHistoryItem(isDarkMode: isDarkMode),
        Expanded(
          child: ListView.builder(
              itemCount: months.length,
              itemBuilder: (BuildContext context, int index) {
                final year = startYear;
                final month = months[index];
                return BlocProvider(
                  create: (context) {
                    return HomeCubit(
                        incomesRepository: IncomesRepository(
                            firebaseIncomeDataSource:
                                FirebaseIncomeDataSource()),
                        spendingsRepository: SpendingsRepository(
                            firebaseSpendingsDataSource:
                                FirebaseSpendingsDataSource()))
                      ..getMonthlyData(month: month, year: year);
                  },
                  child: BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      spendingsInMonth = 0.0;

                      for (final spending in state.spendingDocs) {
                        spendingsInMonth += spending.spendingValue;
                      }

                      incomeInMonth = 0.0;

                      for (final income in state.incomesDocs) {
                        incomeInMonth += income.incomeValue;
                      }
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
                          return _HomePageBody(
                            isDarkMode: isDarkMode,
                            month: month,
                            year: year,
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
                );
              }),
        ),
      ]),
    );
  }
}

class _AllHistoryItem extends StatelessWidget {
  const _AllHistoryItem({
    Key? key,
    required this.isDarkMode,
  }) : super(key: key);

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          color: isDarkMode ? Colors.grey[900] : Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const AllItemsPage()));
              },
              child: Text(
                'Sprawdź całą historię',
                style: TextStyle(
                  color: isDarkMode
                      ? const Color(0xff673ab7)
                      : const Color(0xfff5b041),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      )
    ]);
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({
    Key? key,
    required this.isDarkMode,
    required this.month,
    required this.year,
  }) : super(key: key);

  final bool isDarkMode;
  final int month;
  final int year;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        padding: const EdgeInsets.only(left: 10),
        margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[900] : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => DailyReportsPage(
                month: month,
                year: year,
              ),
            ));
          },
          child: SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat.yMMMM(AppLocalizations.of(context).dateFormat)
                          .format(DateTime(year, month))
                          .toUpperCase(),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      color: Colors.red,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '$spendingsInMonth PLN',
                            style: const TextStyle(
                                fontSize: 11, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '$incomeInMonth PLN',
                            style: const TextStyle(
                                fontSize: 11, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )
    ]);
  }
}
