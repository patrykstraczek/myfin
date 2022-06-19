import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myfin/App/features/home/account_balance_page.dart';
import 'package:myfin/App/features/home/add_page.dart';
import 'package:myfin/App/features/home/incomes_page.dart';
import 'package:myfin/App/features/home/info_page.dart';
import 'package:myfin/App/features/home/my_account_page.dart';

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

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Colors.black54,
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
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Color.fromARGB(255, 174, 152, 100),
              ),
              alignment: Alignment.topCenter,
              height: 194.0,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: currentIndex == 0
                        ? Text(
                            'Suma wydatków',
                            style: GoogleFonts.lato(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Text(
                            'Suma przychodów',
                            style: GoogleFonts.lato(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                  const SizedBox(height: 10),
                  currentIndex == 0
                      ? Text(
                          'Kwota',
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Text(
                          'Kwota2',
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  const SizedBox(height: 40),
                  DataTable(
                      headingRowHeight: 25,
                      dataRowHeight: 20,
                      columns: const [
                        DataColumn(label: Text('Okres')),
                        DataColumn(label: Text('Kwota')),
                      ],
                      rows: [
                        DataRow(cells: [
                          const DataCell(Text('Obecny miesiąc')),
                          if (currentIndex == 0)
                            const DataCell(
                              Text(
                                'wydatków',
                              ),
                            )
                          else
                            const DataCell(
                              Text(
                                'przychodów',
                              ),
                            ),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Poprzedni miesiąc')),
                          if (currentIndex == 0)
                            const DataCell(
                              Text(
                                'wydatków-1msc',
                              ),
                            )
                          else
                            const DataCell(
                              Text(
                                'przychodów-1msc',
                              ),
                            ),
                        ]),
                      ]),
                ],
              ),
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
                    builder: (_) => MyAccountPage(email: widget.user.email),
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
      backgroundColor: const Color.fromARGB(255, 3, 37, 39),
      body: Builder(builder: (context) {
        if (currentIndex == 0) {
          return const AccountBalancePage();
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
        backgroundColor: Colors.white10,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Wydatki',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Wpływy',
          ),
        ],
      ),
    );
  }
}
