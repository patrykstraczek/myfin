import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myfin/App/home_page.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 3, 37, 39),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor: const Color.fromARGB(255, 201, 226, 101),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
            child: Text(
              'Wprowadź saldo',
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 201, 226, 101),
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
          ),
          Text(
            "Konto 1",
            style: GoogleFonts.lato(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const TextField(
            decoration: InputDecoration(hintText: 'Wprowadź saldo'),
          ),
          const SizedBox(
            height: (40),
          ),
          Text(
            "Konto 2",
            style: GoogleFonts.lato(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const TextField(
            decoration: InputDecoration(hintText: 'Wprowadź saldo'),
          ),
          const SizedBox(height: 100),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => HomePage(
                      user: user,
                    ),
                  ),
                );
              },
              child: (const Text('Dalej')))
        ],
      ),
    );
  }
}
