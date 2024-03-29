import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:myfin/App/core/enums.dart';
import 'package:myfin/app/domain/theme/theme_data.dart';
import 'package:myfin/app/features/pages/daily/daily_reports_page.dart';
import 'package:myfin/app/features/pages/home/pages/home_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:myfin/app/features/pages/summaries/cubit/yearly_summaries_cubit.dart';
import 'package:myfin/App/domain/remote_data_sources/incomes_data_source.dart';
import 'package:myfin/App/domain/remote_data_sources/spending_data_source.dart';
import 'package:myfin/App/domain/repositories/incomes_repository.dart';
import 'package:myfin/App/domain/repositories/spendings_repository.dart';

class YearlySummariesPage extends StatefulWidget {
  const YearlySummariesPage({Key? key}) : super(key: key);

  @override
  State<YearlySummariesPage> createState() => _YearlySummariesPageState();
}

DateTime? date;

double spendingsInMonth = 0.0;
double incomeInMonth = 0.0;
double spendingsInYear = 0.0;
double incomeInYear = 0.0;

class _YearlySummariesPageState extends State<YearlySummariesPage> {
  late int startYear;
  List<int> years = [];

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();

    startYear = now.year;
    years.add(startYear); // Add current year to list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).yearlysummaries),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => Theme(
                  data: dialogTheme(isDarkMode),
                  child: AlertDialog(
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(AppLocalizations.of(context).close),
                      ),
                    ],
                    content:
                        Text(AppLocalizations.of(context).yearlysummariesInfo),
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.question_mark,
              color: isDarkMode
                  ? const Color(0xff673ab7)
                  : const Color(0xfff5b041),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          for (int year in years) YearlySummariesPageWidget(year: year),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class YearlySummariesPageWidget extends StatefulWidget {
  const YearlySummariesPageWidget({
    Key? key,
    required this.year,
  }) : super(key: key);

  final int year;

  @override
  State<YearlySummariesPageWidget> createState() =>
      _YearlySummariesPageWidgetState();
}

class _YearlySummariesPageWidgetState extends State<YearlySummariesPageWidget> {
  bool isMonthlySummariesOpen = true;

  @override
  Widget build(BuildContext context) {
    List<Widget> monthlySummaries = [];
    for (int month = 1; month <= 12; month++) {
      monthlySummaries.add(MonthlySummariesBody(
        month: month,
        year: widget.year,
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
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat.y(AppLocalizations.of(context).dateFormat)
                    .format(DateTime(widget.year))
                    .toUpperCase(),
                style: const TextStyle(fontSize: 32),
              ),
              BlocProvider(
                create: (context) => YearlySummariesCubit(
                  incomesRepository: IncomesRepository(
                      firebaseIncomeDataSource: FirebaseIncomeDataSource()),
                  spendingsRepository: SpendingsRepository(
                      firebaseSpendingsDataSource:
                          FirebaseSpendingsDataSource()),
                )..getYearlyData(year: widget.year),
                child: BlocBuilder<YearlySummariesCubit, YearlySummariesState>(
                  builder: (context, state) {
                    spendingsInYear = 0.0;

                    for (final spending in state.spendingDocs) {
                      spendingsInYear += spending.spendingValue;
                    }

                    incomeInYear = 0.0;

                    for (final income in state.incomesDocs) {
                      incomeInYear += income.incomeValue;
                    }
                    switch (state.status) {
                      case Status.initial:
                        return const SizedBox.shrink();
                      case Status.loading:
                        return const Center(
                          child: Text('...'),
                        );
                      case Status.success:
                        return Row(
                          children: [
                            Text('- ${spendingsInYear.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                )),
                            const SizedBox(width: 30),
                            Text(
                              '+ ${incomeInYear.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 10),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isMonthlySummariesOpen =
                                      !isMonthlySummariesOpen;
                                });
                              },
                              child: Icon(
                                isMonthlySummariesOpen
                                    ? Icons.arrow_drop_down
                                    : Icons.arrow_right,
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
          ),
          Column(
            children: isMonthlySummariesOpen
                ? monthlySummaries.toList()
                : <Widget>[], // Use an empty list when it's closed
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
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => DailyReportsPage(
            month: month,
            year: year,
          ),
        ));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                DateFormat.MMMM(AppLocalizations.of(context).dateFormat)
                        .format(DateTime(year, month))
                        .substring(0, 1)
                        .toUpperCase() +
                    DateFormat.MMMM(AppLocalizations.of(context).dateFormat)
                        .format(DateTime(year, month))
                        .substring(1),
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              BlocProvider(
                create: (context) => YearlySummariesCubit(
                  incomesRepository: IncomesRepository(
                      firebaseIncomeDataSource: FirebaseIncomeDataSource()),
                  spendingsRepository: SpendingsRepository(
                      firebaseSpendingsDataSource:
                          FirebaseSpendingsDataSource()),
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

                    return Row(
                      children: [
                        Container(
                          width: 100,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                spendingsInMonth == 0.0
                                    ? '-'
                                    : '- ${spendingsInMonth.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 100,
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
                                incomeInMonth == 0.0
                                    ? '-'
                                    : '+ ${incomeInMonth.toStringAsFixed(2)}',
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
                  },
                ),
              )
            ],
          ),
          const Divider(
            color: Colors.grey,
            thickness: 1,
            height: 16,
          ),
        ],
      ),
    );
  }
}
