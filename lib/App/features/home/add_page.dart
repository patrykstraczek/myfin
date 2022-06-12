import 'package:cloud_firestore/cloud_firestore.dart';
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

  final nameController = TextEditingController();
  final valueController = TextEditingController();

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  var addingIncome = false;
  var name = '';
  var value = 3.0.toString();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('categories').snapshots(),
        builder: (context, snapshot) {
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
                    controller: widget.nameController,
                    onChanged: (newValue) {
                      setState(() {
                        name = newValue;
                      });
                    },
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
                    controller: widget.valueController,
                    keyboardType: TextInputType.number,
                    onChanged: (newValue) {
                      setState(() {
                        value = newValue;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Kwota',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(200, 218, 216, 216),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                if (addingIncome == false) ...[
                  TextButton(
                      onPressed: () {
                        setState(() {
                          addingIncome = true;
                        });
                      },
                      child: Text('Dodaj przychód',
                          style: GoogleFonts.lato(
                            color: const Color.fromARGB(255, 174, 152, 100),
                          )))
                ],
                if (addingIncome == true) ...[
                  TextButton(
                    onPressed: () {
                      setState(() {
                        addingIncome = false;
                      });
                    },
                    child: Text(
                      'Dodaj wydatek',
                      style: GoogleFonts.lato(
                        color: const Color.fromARGB(255, 174, 152, 100),
                      ),
                    ),
                  ),
                ],
                if (addingIncome == false) ...[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
                    child: ElevatedButton(
                      onPressed: () {
                        FirebaseFirestore.instance.collection('spendings').add({
                          'name': widget.nameController.text,
                          'value': widget.valueController.text
                        });
                      },
                      child: const Text('Dodaj'),
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 174, 152, 100),
                        fixedSize: const Size(10, 50),
                      ),
                    ),
                  ),
                ],
                if (addingIncome == true) ...[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
                    child: ElevatedButton(
                      onPressed: () {
                        FirebaseFirestore.instance.collection('incomes').add(
                          {
                            'name': widget.nameController.text,
                            'income': widget.valueController.text
                          },
                        );
                      },
                      child: const Text('Dodaj'),
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 174, 152, 100),
                        fixedSize: const Size(10, 50),
                      ),
                    ),
                  ),
                ]
              ],
            ),
          );
        });
  }
}
