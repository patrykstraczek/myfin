import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:myfin/App/core/enums.dart';
import 'package:myfin/app/features/pages/home/pages/home_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Podsumowanie'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                final year = startYear;

                return _YearlySummariesPageBody(
                  year: year,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _YearlySummariesPageBody extends StatelessWidget {
  const _YearlySummariesPageBody({
    Key? key,
    required this.year,
  }) : super(key: key);

  final int year;

  @override
  Widget build(BuildContext context) {
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
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MonthlySummariesBody(month: 'Styczeń'),
                  MonthlySummariesBody(month: 'Luty'),
                  MonthlySummariesBody(month: 'Marzec'),
                  MonthlySummariesBody(month: 'Kwiecień'),
                  MonthlySummariesBody(month: 'Maj'),
                  MonthlySummariesBody(month: 'Czerwiec'),
                  MonthlySummariesBody(month: 'Lipiec'),
                  MonthlySummariesBody(month: 'Sierpień'),
                  MonthlySummariesBody(month: 'Wrzesień'),
                  MonthlySummariesBody(month: 'Październik'),
                  MonthlySummariesBody(month: 'Listopad'),
                  MonthlySummariesBody(month: 'Grudzień'),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class MonthlySummariesBody extends StatelessWidget {
  MonthlySummariesBody({
    required this.month,
    Key? key,
  }) : super(key: key);

  String month;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(month),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    '-3300',
                    style: TextStyle(
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    '+4000',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
