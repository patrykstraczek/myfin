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
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => AddPage(),
          ));
        },
      ),
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: const Color.fromARGB(255, 174, 152, 100),
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 3, 37, 39),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 174, 152, 100),
              ),
              child: Text(
                'MyFin',
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  color: const Color.fromARGB(255, 3, 37, 39),
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
            ListTile(
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
            Divider(color: Colors.white),
            ListTile(
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
        backgroundColor: const Color.fromARGB(255, 174, 152, 100),
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
