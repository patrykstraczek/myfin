import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:myfin/App/core/enums.dart';
import 'package:myfin/app/features/pages/add/widgets/currency_buttons.dart';
import 'package:myfin/app/features/pages/daily/cubit/daily_reports_cubit.dart';
import 'package:myfin/app/features/pages/details/details_page.dart';
import 'package:myfin/app/features/pages/home/pages/home_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:myfin/app/widgets/floating_action_button.dart';
import 'package:myfin/app/injection_container.dart';
import 'package:myfin/app/core/currency_notifier.dart';
import 'package:provider/provider.dart';

class DailyReportsPage extends StatelessWidget {
  const DailyReportsPage({
    Key? key,
    required this.month,
    required this.year,
  }) : super(key: key);

  final int month;
  final int year;

  @override
  Widget build(BuildContext context) {
    int currentDay = DateTime.now().day;
    int daysInMonth = DateTime(year, month + 1, 0).day;
    int daysToDisplay = daysInMonth;
    if (month == DateTime.now().month && year == DateTime.now().year) {
      daysToDisplay = currentDay;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          DateFormat.yMMMM(AppLocalizations.of(context).dateFormat)
              .format(DateTime(year, month))
              .toUpperCase(),
        ),
        centerTitle: true,
      ),
      floatingActionButton: myFloatingActionButton(context),
      body: BlocProvider(
        create: (context) {
          return getIt<DailyReportsCubit>()
            ..getMonthlyData(month: month, year: year);
        },
        child: BlocBuilder<DailyReportsCubit, DailyReportsState>(
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
                    Column(
                      children: List.generate(
                        daysToDisplay,
                        (index) {
                          final day = index + 1;
                          final date = DateTime(year, month, day);
                          return _DailyReportsWidget(selectedDay: date);
                        },
                      ).toList().reversed.toList(),
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
    );
  }
}

class _DailyReportsWidget extends StatefulWidget {
  const _DailyReportsWidget({
    Key? key,
    required this.selectedDay,
  }) : super(key: key);

  final DateTime selectedDay;

  @override
  State<_DailyReportsWidget> createState() => _DailyReportsWidgetState();
}

double spendingsInDay = 0.0;
double incomeInDay = 0.0;

class _DailyReportsWidgetState extends State<_DailyReportsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              builder: (_) => DetailsPage(
                    selectedDay: widget.selectedDay,
                  )));
        },
        child: SizedBox(
          height: 60,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat.MEd(AppLocalizations.of(context).dateFormat)
                      .format(widget.selectedDay),
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            BlocProvider(
              create: (context) {
                return getIt<DailyReportsCubit>()
                  ..getDailyStream(selectedDay: widget.selectedDay);
              },
              child: BlocBuilder<DailyReportsCubit, DailyReportsState>(
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
                      spendingsInDay = 0.0;

                      for (final spending in state.spendingDocs) {
                        spendingsInDay += spending.spendingValue;
                      }

                      incomeInDay = 0.0;

                      for (final income in state.incomesDocs) {
                        incomeInDay += income.incomeValue;
                      }

                      return DailySummariesWidget(
                        selectedDay: widget.selectedDay,
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
          ]),
        ),
      ),
    );
  }
}

class DailySummariesWidget extends StatelessWidget {
  const DailySummariesWidget({
    Key? key,
    required this.selectedDay,
  }) : super(key: key);

  final DateTime selectedDay;

  @override
  Widget build(BuildContext context) {
    final currencyNotifier = Provider.of<CurrencyNotifier>(context);

    final selectedCurrency = currencyNotifier.selectedCurrency;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                spendingsInDay == 0.0
                    ? '-'
                    : '$spendingsInDay $selectedCurrency',
                style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                incomeInDay == 0.0 ? '-' : '$incomeInDay $selectedCurrency',
                style: const TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
