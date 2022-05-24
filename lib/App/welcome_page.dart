import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myfin/App/login_page.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 3, 37, 39),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'MyFin - Moje Finanse',
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 174, 152, 100),
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
            const SizedBox(height: 240),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => LoginPage(),
                  ),
                );
              },
              child: Text(
                'Rozpocznij',
                style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(240, 60),
                primary: const Color.fromARGB(255, 174, 152, 100),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
