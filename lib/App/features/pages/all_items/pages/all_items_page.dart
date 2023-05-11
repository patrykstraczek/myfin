import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myfin/app/domain/theme/colors.dart';
import 'package:myfin/app/features/pages/home/pages/home_page.dart';
import 'package:myfin/app/features/pages/all_items/cubit/all_items/all_items_cubit.dart';
import 'package:myfin/App/features/pages/all_items/pages/incomes_page.dart';
import 'package:myfin/App/features/pages/all_items/pages/spendings_page.dart';
import 'package:myfin/App/injection_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:myfin/app/widgets/floating_action_button.dart';
import 'package:provider/provider.dart';
import 'package:myfin/app/core/currency_notifier.dart';

class AllItemsPage extends StatefulWidget {
  const AllItemsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AllItemsPage> createState() => _AllItemsPageState();
}

int currentIndex = 0;
double todaySpendings = 0.0;
double thisMonthSpending = 0.0;
double previousMonthSpending = 0.0;
double todayIncome = 0.0;
double thisMonthIncome = 0.0;
double previousMonthIncome = 0.0;

class _AllItemsPageState extends State<AllItemsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MyFloatingActionButton(
        isDarkMode: isDarkMode,
      ),
      appBar: AppBar(
        centerTitle: true,
        title: currentIndex == 0
            ? Text(AppLocalizations.of(context).todaySpendings)
            : Text(AppLocalizations.of(context).todayIncome),
        surfaceTintColor: accentColors(),
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
        ),
        backgroundColor: accentColors(),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              color: accentColors(),
            ),
            alignment: Alignment.topCenter,
            height: 110.0,
            child: _HeaderBody(currentIndex: currentIndex),
          ),
        ),
      ),
      body: Builder(builder: (context) {
        if (currentIndex == 0) {
          return const SpendingsPage();
        }
        return const IncomesPage();
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

class _HeaderBody extends StatelessWidget {
  _HeaderBody({Key? key, required this.currentIndex}) : super(key: key);

  final int currentIndex;
  final today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final currencyNotifier = Provider.of<CurrencyNotifier>(context);
    final selectedCurrency = currencyNotifier.selectedCurrency;

    return Column(
      children: [
        BlocProvider(
          create: (context) {
            return getIt<AllItemsCubit>()..getDailyStream(selectedDay: today);
          },
          child: BlocBuilder<AllItemsCubit, AllItemsState>(
            builder: (context, state) {
              List<dynamic> documents;

              if (currentIndex == 0) {
                documents = state.spendingDocs;
              } else {
                documents = state.incomesDocs;
              }
              double todayValue = 0.0;

              for (final doc in documents) {
                if (currentIndex == 0) {
                  todayValue += doc.spendingValue;
                } else {
                  todayValue += doc.incomeValue;
                }
              }

              return Text(
                '${todayValue.toStringAsFixed(2)} $selectedCurrency',
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context).thisMonth,
                  ),
                  BlocProvider(
                    create: (context) {
                      return getIt<AllItemsCubit>()..getThisMonthStream();
                    },
                    child: BlocBuilder<AllItemsCubit, AllItemsState>(
                      builder: (context, state) {
                        List<dynamic> documents;

                        if (currentIndex == 0) {
                          documents = state.spendingDocs;
                        } else {
                          documents = state.incomesDocs;
                        }
                        double thisMonthValue = 0.0;

                        for (final doc in documents) {
                          if (currentIndex == 0) {
                            thisMonthValue += doc.spendingValue;
                          } else {
                            thisMonthValue += doc.incomeValue;
                          }
                        }

                        return Text(
                          '${thisMonthValue.toStringAsFixed(2)} $selectedCurrency',
                        );
                      },
                    ),
                  ),
                ],
              ),
              BlocProvider(
                create: (context) {
                  return getIt<AllItemsCubit>()..getPreviousMonthStream();
                },
                child: BlocBuilder<AllItemsCubit, AllItemsState>(
                  builder: (context, state) {
                    List<dynamic> documents;

                    if (currentIndex == 0) {
                      documents = state.spendingDocs;
                    } else {
                      documents = state.incomesDocs;
                    }
                    double previousMonthValue = 0.0;

                    for (final doc in documents) {
                      if (currentIndex == 0) {
                        previousMonthValue += doc.spendingValue;
                      } else {
                        previousMonthValue += doc.incomeValue;
                      }
                    }

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context).previousMonth,
                        ),
                        Text(
                          '${previousMonthValue.toStringAsFixed(2)} $selectedCurrency',
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
