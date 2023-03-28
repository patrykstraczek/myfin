import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:myfin/App/core/enums.dart';
import 'package:myfin/App/features/pages/add/pages/add_page.dart';
import 'package:myfin/app/domain/theme/theme_provider.dart';
import 'package:myfin/App/features/pages/all_items/pages/all_items_page.dart';
import 'package:myfin/App/features/pages/home/cubit/home_cubit.dart';
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

class _HomePageState extends State<HomePage> {
  late int startYear;
  late int startMonth;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();

    startYear = now.year;
    startMonth = now.month;
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    final months =
        (today.year - startYear) * 12 + (today.month - startMonth) + 1;

    return Scaffold(
      drawer: DrawerWidget(isDarkMode: isDarkMode),
      appBar: AppBar(
        surfaceTintColor: isDarkMode ? Colors.grey[900] : Colors.white,
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
        title: const Text('Raporty'),
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
          child: BlocProvider(
            create: (context) {
              return getIt<HomeCubit>()..start();
            },
            child: ListView.builder(
                itemCount: months,
                itemBuilder: (BuildContext context, int index) {
                  final year = startYear + ((startMonth + index - 1) ~/ 12);
                  final month = (startMonth + index - 1) % 12 + 1;
                  return BlocProvider(
                    create: (context) {
                      return getIt<HomeCubit>()..start();
                    },
                    child: BlocBuilder<HomeCubit, HomeState>(
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
              child: const Text(
                'Sprawdź całą historię',
                style: TextStyle(
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
                    )));
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
                          .format(DateTime(year, month)),
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            '-120 PLN',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            '+25 PLN',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
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
