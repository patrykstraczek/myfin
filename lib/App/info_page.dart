import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 174, 152, 100),
        title: const Text('Informacje'),
      ),
      backgroundColor: const Color.fromARGB(255, 3, 37, 39),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Twórcy:',
            style: GoogleFonts.lato(
              color: const Color.fromARGB(255, 174, 152, 100),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Patryk Strączek',
            style: GoogleFonts.lato(
              color: const Color.fromARGB(255, 174, 152, 100),
            ),
          ),
          Text('E-mail: patrykstraczek99@gmail.com',
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 174, 152, 100),
              )),
          const SizedBox(height: 300),
          Text(
            'Version 0.1',
            style: GoogleFonts.lato(
              color: Colors.white,
            ),
          ),
        ],
      )),
    );
  }
}
