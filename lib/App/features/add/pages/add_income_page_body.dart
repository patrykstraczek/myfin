import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfin/App/features/add/widgets/calendar.dart';

class AddIncomePageBody extends StatefulWidget {
  AddIncomePageBody({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  final valueController = TextEditingController();

  @override
  State<AddIncomePageBody> createState() => _AddIncomePageBodyState();
}

var incomeName = '';
double? incomeValue;

class _AddIncomePageBodyState extends State<AddIncomePageBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
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
                  incomeName = newValue;
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
                  incomeValue = double.parse(newValue);
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: const MyCalendar(),
          ),
          const SizedBox(height: 150),
          Padding(
            padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                FirebaseFirestore.instance
                    .collection('users')
                    .doc('2SHBQGWMo4JZleshrllF')
                    .collection('incomes')
                    .add({
                  'incomeName': incomeName,
                  'incomeValue': incomeValue,
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
      ),
    );
  }
}
