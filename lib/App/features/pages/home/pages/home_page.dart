import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:myfin/App/features/pages/add/pages/add_page.dart';
import 'package:myfin/App/features/pages/auth/pages/user_profile.dart';
import 'package:myfin/App/features/pages/exchange/pages/exchange_rates_page.dart';
import 'package:myfin/App/features/pages/home/cubit/home/home_cubit.dart';
import 'package:myfin/App/features/pages/home/pages/incomes_page.dart';
import 'package:myfin/App/features/pages/home/pages/spendings_page.dart';
import 'package:myfin/App/domain/theme/theme_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  State<HomePage> createState() => _HomePageState();
}

DateTime today = DateTime.now();
var currentIndex = 0;
var incomesSum = 0.0;
var spendingsSum = 0.0;
var todaySpendings = 0.0;
var balanceThisMonth = incomesSum - spendingsSum;

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
      appBar: const _AppBarWidget(),
      drawer: const _DrawerWidget(),
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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Wydatki',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'Wpływy',
          ),
        ],
      ),
    );
  }
}

// Drawer
class _DrawerWidget extends StatelessWidget {
  const _DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey[900],
            ),
            child: Text(
              'MyFin',
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                color: Colors.amber,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.person,
              color: Colors.white54,
            ),
            title: Text('Profil',
                style: GoogleFonts.lato(
                  color: Colors.white,
                )),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const UserProfile(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.moving,
              color: Colors.white54,
            ),
            title: Text('Kursy walut',
                style: GoogleFonts.lato(
                  color: Colors.white,
                )),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const ExchangeRatesPage(),
                ),
              );
            },
          ),
          const Divider(color: Colors.white),
          AboutListTile(
            icon: const Icon(
              Icons.info,
              color: Colors.white54,
            ),
            applicationIcon: const Icon(Icons.info),
            applicationName: 'MyFin - Moje Finanse',
            applicationVersion: 'ver. 0.1',
            applicationLegalese: 'Patryk Strączek',
            child: Text('Informacje',
                style: GoogleFonts.lato(
                  color: Colors.white,
                )),
          ),
        ],
      ),
    );
  }
}

//AppBar
class _AppBarWidget extends StatefulWidget with PreferredSizeWidget {
  const _AppBarWidget({Key? key}) : super(key: key);

  @override
  State<_AppBarWidget> createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(250);
}

class _AppBarWidgetState extends State<_AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: darkMode ? Colors.black : Colors.white,
        foregroundColor: darkMode ? Colors.white : Colors.black,
        toolbarHeight: 250,
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
                child:
//spendings
                    currentIndex == 0
                        ? BlocProvider(
                            create: (context) => HomeCubit()..start(),
                            child: BlocBuilder<HomeCubit, HomeState>(
                              builder: (context, state) {
                                state.documents;

                                if (state.errorMessage.isNotEmpty) {
                                  return Center(
                                      child: Text(
                                          'Something went wrong ${state.errorMessage}'));
                                }

                                if (state.isLoading) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }

                                final documents = state.documents;

                                spendingsSum = 0.0;
                                todaySpendings = 0.0;

                                for (final doc in documents) {
                                  spendingsSum += (doc['spending_value']);
                                  todaySpendings += (doc['spending_value']);
                                }
                                return Column(children: [
                                  Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        'Dziś:',
                                        style: GoogleFonts.lato(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                  const SizedBox(height: 10),
                                  Text(
                                    '$todaySpendings zł',
                                    style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 64, vertical: 16),
                                    child: Column(children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('Obecny miesiąc'),
                                          Text('$spendingsSum zł'),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('Poprzedni miesiąc'),
                                          Text('$spendingsSum zł'),
                                        ],
                                      ),
                                    ]),
                                  )
                                ]);
                              },
                            ),
                          )
//incomes
                        : BlocProvider(
                            create: (context) => HomeIncomeCubit()..start(),
                            child: BlocBuilder<HomeIncomeCubit, HomeState>(
                              builder: (context, state) {
                                state.documents;

                                if (state.errorMessage.isNotEmpty) {
                                  return Center(
                                      child: Text(
                                          'Something went wrong ${state.errorMessage}'));
                                }

                                if (state.isLoading) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }

                                final documents = state.documents;

                                incomesSum = 0.0;

                                for (final doc in documents) {
                                  incomesSum += (doc['income_value']);
                                }
                                return Column(children: [
                                  Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        'Dziś:',
                                        style: GoogleFonts.lato(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                  const SizedBox(height: 10),
                                  Text(
                                    '$incomesSum zł',
                                    style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 64, vertical: 16),
                                    child: Column(children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('Obecny miesiąc'),
                                          Text('$incomesSum zł'),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('Poprzedni miesiąc'),
                                          Text('$incomesSum zł'),
                                        ],
                                      ),
                                    ]),
                                  )
                                ]);
                              },
                            )))));
  }
}