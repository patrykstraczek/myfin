import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:myfin/App/features/pages/add/pages/add_page.dart';
import 'package:myfin/App/features/pages/home/cubit/home/home_cubit.dart';
import 'package:myfin/App/features/pages/home/pages/incomes_page.dart';
import 'package:myfin/App/features/pages/home/pages/spendings_page.dart';
import 'package:myfin/App/features/pages/home/widgets/drawer.dart';
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

var currentIndex = 0;
var incomesSum = 0.0;
var spendingsSum = 0.0;
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
      appBar: AppBar(
        backgroundColor: darkMode ? Colors.black : Colors.grey[200],
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
              child: Column(children: [
                Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'Stan:',
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                const SizedBox(height: 10),
                Text(
                  '$balanceThisMonth zł',
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
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

                            for (final doc in documents) {
                              [spendingsSum += (doc['spendingValue'])];
                            }

                            return DataTable(
                                columnSpacing: 80,
                                headingRowHeight: 25,
                                dataRowHeight: 20,
                                columns: const [
                                  DataColumn(label: Text('Okres')),
                                  DataColumn(label: Text('Suma wydatków:'))
                                ],
                                rows: [
                                  DataRow(cells: [
                                    const DataCell(Text('Obecny miesiąc')),
                                    DataCell(
                                      Text(
                                        '$spendingsSum zł',
                                      ),
                                    )
                                  ]),
                                  const DataRow(cells: [
                                    DataCell(Text('Poprzedni miesiąc')),
                                    DataCell(Text('wydatków-1msc'))
                                  ])
                                ]);
                          },
                        ),
                      )
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

                            for (final doc in documents) {
                              [incomesSum += (doc['incomeValue'])];
                            }

                            return DataTable(
                                columnSpacing: 80,
                                headingRowHeight: 25,
                                dataRowHeight: 20,
                                columns: const [
                                  DataColumn(label: Text('Okres')),
                                  DataColumn(label: Text('Suma przychodów:'))
                                ],
                                rows: [
                                  DataRow(cells: [
                                    const DataCell(Text('Obecny miesiąc')),
                                    DataCell(
                                      Text(
                                        '$incomesSum',
                                      ),
                                    )
                                  ]),
                                  const DataRow(cells: [
                                    DataCell(Text('Poprzedni miesiąc')),
                                    DataCell(Text('przychodów-1msc'))
                                  ])
                                ]);
                          },
                        ),
                      )
              ]),
            )),
      ),
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
