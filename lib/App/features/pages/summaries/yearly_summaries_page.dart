import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:myfin/App/core/enums.dart';
import 'package:myfin/app/features/pages/home/pages/home_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:myfin/app/features/pages/summaries/cubit/yearly_summaries_cubit.dart';
import 'package:provider/provider.dart';
import 'package:myfin/App/domain/remote_data_sources/incomes_data_source.dart';
import 'package:myfin/App/domain/remote_data_sources/spending_data_source.dart';
import 'package:myfin/app/domain/repositories/incomes_repository.dart';
import 'package:myfin/app/domain/repositories/spendings_repository.dart';

class YearlySummariesPage extends StatefulWidget {
  const YearlySummariesPage({Key? key}) : super(key: key);

  @override
  State<YearlySummariesPage> createState() => _YearlySummariesPageState();
}

DateTime? date;

double spendingsInMonth = 0.0;
double incomeInMonth = 0.0;

class _YearlySummariesPageState extends State<YearlySummariesPage> {
  late int startYear;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();

    startYear = now.year;
  }

  @override
  Widget build(BuildContext context) {
    final year = startYear;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Podsumowanie'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Zamknij'))
                    ],
                    content: Text(
                        'Wraz z rozpoczęciem nowego roku pojawią się tutaj Twoje roczne zestawienia.'),
                  ),
                );
              },
              icon: Icon(
                Icons.question_mark,
                color: isDarkMode
                    ? const Color(0xff673ab7)
                    : const Color(0xfff5b041),
              )),
        ],
      ),
      body: ListView(
        children: [
          _YearlySummariesPageWidget(year: year),
          _YearlySummariesPageWidget(year: 2022),
          _YearlySummariesPageWidget(year: 2021),
          _YearlySummariesPageWidget(year: 2020),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _YearlySummariesPageWidget extends StatelessWidget {
  const _YearlySummariesPageWidget({
    Key? key,
    required this.year,
  }) : super(key: key);

  final int year;

  @override
  Widget build(BuildContext context) {
    List<Widget> monthlySummaries = [];
    for (int month = 1; month <= 12; month++) {
      monthlySummaries.add(MonthlySummariesBody(
        month: month,
        year: year,
      ));
    }

    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[900] : Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        children: [
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat.y(AppLocalizations.of(context).dateFormat)
                          .format(DateTime(year))
                          .toUpperCase(),
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Text('-49280',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '+62820',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: monthlySummaries,
          )
        ],
      ),
    );
  }
}

class MonthlySummariesBody extends StatelessWidget {
  const MonthlySummariesBody({
    required this.month,
    required this.year,
    Key? key,
  }) : super(key: key);

  final int month;
  final int year;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(DateFormat.MMMM(AppLocalizations.of(context).dateFormat)
                .format(DateTime(year, month))
                .substring(0, 1)
                .toUpperCase() +
            DateFormat.MMMM(AppLocalizations.of(context).dateFormat)
                .format(DateTime(year, month))
                .substring(1)),
        BlocProvider(
          create: (context) => YearlySummariesCubit(
            incomesRepository: IncomesRepository(
                firebaseIncomeDataSource: FirebaseIncomeDataSource()),
            spendingsRepository: SpendingsRepository(
                firebaseSpendingsDataSource: FirebaseSpendingsDataSource()),
          )..getMonthlyData(month: month, year: year),
          child: BlocBuilder<YearlySummariesCubit, YearlySummariesState>(
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
                  return Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              spendingsInMonth == 0.0
                                  ? '0'
                                  : '+ $spendingsInMonth',
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              incomeInMonth == 0.0 ? '0' : ' + $incomeInMonth',
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
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
      ],
    );
  }
}
