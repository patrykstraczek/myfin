import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:myfin/App/features/pages/add/pages/add_page.dart';
import 'package:myfin/App/features/pages/home/cubit/home/home_cubit.dart';
import 'package:myfin/App/features/pages/home/pages/incomes_page.dart';
import 'package:myfin/App/features/pages/home/pages/spendings_page.dart';
import 'package:myfin/App/domain/theme/theme_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:myfin/App/widgets/drawer_widget.dart';
import 'package:myfin/app/injection_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

int currentIndex = 0;
double todaySpendings = 0.0;
double thisMonthSpending = 0.0;
double previousMonthSpending = 0.0;
double todayIncome = 0.0;
double thisMonthIncome = 0.0;
double previousMonthIncome = 0.0;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white12,
        foregroundColor: Colors.teal,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => const AddPage(),
          ));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
          toolbarHeight: 250,
          backgroundColor: darkMode ? Colors.black : Colors.white,
          foregroundColor: darkMode ? Colors.white : Colors.black,
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  darkMode = !darkMode;
                });
              },
              icon: Icon(darkMode ? iconDark : iconLight),
            )
          ],
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Color.fromARGB(255, 148, 112, 4),
                ),
                alignment: Alignment.topCenter,
                height: 194.0,
                child: currentIndex == 0
                    ? const _SpendingHeaderBody()
                    : const _IncomeHeaderBody(),
              ))),
      drawer: const DrawerWidget(),
      body: Builder(builder: (context) {
        if (currentIndex == 0) {
          return const SpendingsPage();
        }
        return const IncomesPage();
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        backgroundColor: Colors.grey[850],
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

class _SpendingHeaderBody extends StatelessWidget {
  const _SpendingHeaderBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            AppLocalizations.of(context).todaySpendings,
            style: GoogleFonts.lato(
              fontSize: 20,
            ),
          )),
      const SizedBox(height: 10),
      BlocProvider(
        create: (context) {
          return getIt<HomeCubit>()..getTodaySpendings();
        },
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            final documents = state.documents;
            todaySpendings = 0.0;

            for (final doc in documents) {
              todaySpendings += (doc['spending_value']);
            }
            return Text(
              '$todaySpendings PLN',
              style: GoogleFonts.lato(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            );
          },
        ),
      ),
      const SizedBox(height: 20),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 16),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.of(context).thisMonth),
              BlocProvider(
                create: (context) {
                  return getIt<HomeCubit>()..getThisMonthSpendings();
                },
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    final documents = state.documents;

                    thisMonthSpending = 0.0;

                    for (final doc in documents) {
                      thisMonthSpending += (doc['spending_value']);
                    }
                    return Text('$thisMonthSpending PLN');
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          BlocProvider(
            create: (context) {
              return getIt<HomeCubit>()..getPreviousMonthSpendings();
            },
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                final documents = state.documents;

                previousMonthSpending = 0.0;

                for (final doc in documents) {
                  previousMonthSpending += (doc['spending_value']);
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context).previousMonth),
                    Text('$previousMonthSpending PLN'),
                  ],
                );
              },
            ),
          ),
        ]),
      )
    ]);
  }
}

class _IncomeHeaderBody extends StatelessWidget {
  const _IncomeHeaderBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            AppLocalizations.of(context).todayIncome,
            style: GoogleFonts.lato(
              fontSize: 20,
            ),
          )),
      const SizedBox(height: 10),
      BlocProvider(
        create: (context) {
          return getIt<HomeCubit>()..getTodayIncome();
        },
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            final documents = state.documents;
            todayIncome = 0.0;

            for (final doc in documents) {
              todayIncome += (doc['income_value']);
            }
            return Text(
              '$todayIncome PLN',
              style: GoogleFonts.lato(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            );
          },
        ),
      ),
      const SizedBox(height: 20),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 16),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.of(context).thisMonth),
              BlocProvider(
                create: (context) {
                  return getIt<HomeCubit>()..getThisMonthIncome();
                },
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    final documents = state.documents;

                    thisMonthIncome = 0.0;

                    for (final doc in documents) {
                      thisMonthIncome += (doc['income_value']);
                    }
                    return Text('$thisMonthIncome PLN');
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          BlocProvider(
            create: (context) {
              return getIt<HomeCubit>()..getPreviousMonthIncome();
            },
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                final documents = state.documents;

                previousMonthIncome = 0.0;

                for (final doc in documents) {
                  previousMonthIncome += (doc['income_value']);
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context).previousMonth),
                    Text('$previousMonthIncome PLN'),
                  ],
                );
              },
            ),
          ),
        ]),
      )
    ]);
  }
}
