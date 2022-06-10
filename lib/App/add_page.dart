import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

@override
Widget build(BuildContext context) {
  return AddPage();
}

class AddPage extends StatefulWidget {
  AddPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final controller = TextEditingController();

  var AddingIncome = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dodaj wydatek'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 174, 152, 100),
      ),
      backgroundColor: const Color.fromARGB(255, 3, 37, 39),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Nazwa',
                hintStyle: TextStyle(
                  color: Color.fromARGB(200, 218, 216, 216),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Kwota',
                hintStyle: TextStyle(
                  color: Color.fromARGB(200, 218, 216, 216),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          if (AddingIncome == false) ...[
            TextButton(
                onPressed: () {
                  setState(() {
                    AddingIncome = true;
                  });
                },
                child: Text('Dodaj przychód',
                    style: GoogleFonts.lato(
                      color: const Color.fromARGB(255, 174, 152, 100),
                    )))
          ],
          if (AddingIncome == true) ...[
            TextButton(
                onPressed: () {
                  setState(() {
                    AddingIncome = false;
                  });
                },
                child: Text('Dodaj wydatek',
                    style: GoogleFonts.lato(
                      color: const Color.fromARGB(255, 174, 152, 100),
                    )))
          ],
        ],
      ),
    );
  }
}
