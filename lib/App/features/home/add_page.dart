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
  double? _value;
  double? _income;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('categories').snapshots(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: addingIncome == false
                  ? const Text('Dodaj wydatek')
                  : const Text('Dodaj przychód'),
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
                    onChanged: (newValue) {
                      setState(() {
                        _value = double.parse(newValue);
                      });
                    },
                    keyboardType: TextInputType.number,
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
                      child: Text('Chcę dodać przychód',
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
                      'Chcę dodać wydatek',
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
                          'name': name,
                          'value': _value,
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
                          {'name': name, 'income': _income},
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
