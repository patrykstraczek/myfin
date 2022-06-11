import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myfin/App/features/home/info_page.dart';
import 'package:myfin/app/cubit/root_cubit.dart';

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(child: SizedBox(height: 100)),
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
              const SizedBox(height: 250),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const InfoPage()),
                  );
                },
                child: Text(
                  'Informacje',
                  style: GoogleFonts.lato(
                    color: const Color.fromARGB(255, 174, 152, 100),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
