import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myfin/App/features/auth/pages/user_profile.dart';
import 'package:myfin/App/features/add/add_page.dart';
import 'package:myfin/App/features/home/spendings_page.dart';
import 'package:myfin/App/features/home/cubit/home_cubit.dart';
import 'package:myfin/App/features/home/incomes_page.dart';
import 'package:myfin/App/features/home/info_page.dart';

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
        child: const Icon(Icons.add),
        backgroundColor: Colors.white12,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => AddPage(),
          ));
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 250,
        bottom: PreferredSize(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Color.fromARGB(255, 174, 152, 100),
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
                  '$balanceThisMonth',
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
                                        '$spendingsSum',
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
            ),
            preferredSize: const Size.fromHeight(0)),
      ),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 3, 37, 39),
              ),
              child: Text(
                'MyFin',
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  color: const Color.fromARGB(255, 174, 152, 100),
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
              title: Text('Moje konto',
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
            const Divider(color: Colors.white),
            ListTile(
              leading: const Icon(
                Icons.info,
                color: Colors.white54,
              ),
              title: Text('Informacje',
                  style: GoogleFonts.lato(
                    color: Colors.white,
                  )),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const InfoPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
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
        backgroundColor: const Color.fromARGB(255, 3, 37, 39),
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
