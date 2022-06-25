import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  DateTime actualDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc('2SHBQGWMo4JZleshrllF')
            .collection('categories')
            .snapshots(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: addingIncome == false
                  ? RichText(
                      text: TextSpan(
                        text: "Dodaj ",
                        style:
                            GoogleFonts.lato(color: Colors.white, fontSize: 20),
                        children: const <TextSpan>[
                          TextSpan(
                              text: 'Wydatek',
                              style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    )
                  : RichText(
                      text: TextSpan(
                        text: "Dodaj ",
                        style:
                            GoogleFonts.lato(color: Colors.white, fontSize: 20),
                        children: const <TextSpan>[
                          TextSpan(
                              text: 'Przychód',
                              style: TextStyle(color: Colors.green)),
                        ],
                      ),
                    ),
              centerTitle: true,
              backgroundColor: Colors.black,
            ),
            backgroundColor: const Color.fromARGB(255, 3, 37, 39),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    controller: widget.nameController,
                    textCapitalization: TextCapitalization.sentences,
                    style: const TextStyle(color: Colors.white),
                    onChanged: (newValue) {
                      setState(() {
                        name = newValue;
                      });
                    },
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Nazwa (opcjonalnie)',
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
                    style: const TextStyle(color: Colors.white),
                    onChanged: (newValue) {
                      setState(() {
                        _value = double.parse(newValue);
                      });
                    },
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => FocusScope.of(context).unfocus(),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Kwota',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(200, 218, 216, 216),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now().subtract(
                          const Duration(days: 365),
                        ),
                        lastDate: DateTime.now());
                  },
                  child: Text(actualDate.toString()),
                ),
                if (addingIncome == false) ...[
                  TextButton(
                      onPressed: () {
                        setState(() {
                          addingIncome = true;
                        });
                      },
                      child: Text('Chcę dodać przychód',
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
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
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
                if (addingIncome == false) ...[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc('2SHBQGWMo4JZleshrllF')
                            .collection('spendings')
                            .add({
                          'spendingName': name,
                          'spendingValue': _value,
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
                        Navigator.pop(context);
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc('2SHBQGWMo4JZleshrllF')
                            .collection('incomes')
                            .add(
                          {
                            'incomeName': name,
                            'incomeValue': _value,
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
                ],
              ],
            ),
          );
        });
  }
}
