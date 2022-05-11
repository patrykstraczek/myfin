import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FirstPage(),
    );
  }
}

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
                color: const Color.fromARGB(255, 201, 226, 101),
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
            const SizedBox(height: 240),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const SecondPage(),
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
                primary: const Color.fromARGB(255, 201, 226, 101),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 3, 37, 39),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 201, 226, 101),
        title: const Text("Wprowadź saldo"),
      ),
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
            color: const Color.fromARGB(255, 201, 226, 101),
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
            child: Text(
              'Wprowadź saldo',
              style: GoogleFonts.lato(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          const SizedBox(height: 100),
          Container(
            color: const Color.fromARGB(255, 201, 226, 101),
            padding: const EdgeInsets.all(25),
            margin: EdgeInsets.all(20),
            child: const Text('Konto 1'),
          ),
          const SizedBox(height: 30),
          Container(
            color: const Color.fromARGB(255, 201, 226, 101),
            padding: const EdgeInsets.all(25),
            margin: EdgeInsets.all(20),
            child: const Text('Konto 1'),
          ),
          const SizedBox(height: 100),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Wróć (później dalej)',
              style: GoogleFonts.lato(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(10, 50),
              primary: const Color.fromARGB(255, 181, 185, 183),
            ),
          ),
        ],
      ),
    );
  }
}
