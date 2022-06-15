import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAccountPage extends StatelessWidget {
  const MyAccountPage({
    Key? key,
    required this.email,
  }) : super(key: key);

  final String? email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 174, 152, 100),
          title: const Text('Moje konto'),
        ),
        backgroundColor: const Color.fromARGB(255, 3, 37, 39),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 150),
              Text(
                'Jesteś zalogowany jako:',
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                '$email',
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                child: const Text('Wyloguj'),
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 174, 152, 100),
                ),
              ),
            ],
          ),
        ));
  }
}
