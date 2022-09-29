/* import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:myfin/App/features/add/widgets/calendar.dart';

class AddIncomePageBody extends StatefulWidget {
  AddIncomePageBody({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  final valueController = TextEditingController();

  @override
  State<AddIncomePageBody> createState() => _AddIncomePageBodyState();
}

List<bool> isSelected = List.generate(5, (_) => false);

var incomeName = '';
double? incomeValue;
DateTime? actualDate;

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
          const SizedBox(height: 50),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Text(
              'Data:',
              style: GoogleFonts.lato(
                color: Colors.white,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: MyCalendar(
              onDateChanged: (newValue) {
                setState(() {
                  actualDate = newValue;
                });
              },
              selectedDateFormatted: actualDate == null
                  ? null
                  : DateFormat.yMMMEd().format(actualDate!),
            ),
          ),
          const SizedBox(height: 100),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Text(
              'Kategoria:',
              style: GoogleFonts.lato(
                color: Colors.white,
              ),
            ),
          ),
          Column(
            children: [
              ToggleButtons(
                children: const [
                  Icon(Icons.monetization_on),
                  Icon(Icons.people),
                  Icon(Icons.local_post_office),
                  Icon(Icons.home),
                  Icon(Icons.recycling),
                ],
                color: Colors.white,
                selectedColor: Colors.green,
                fillColor: Colors.transparent,
                renderBorder: false,
                isSelected: isSelected,
                onPressed: (int newIndex) {
                  setState(() {
                    for (int index = 0; index < isSelected.length; index++) {
                      if (index == newIndex) {
                        isSelected[index] = true;
                      } else {
                        isSelected[index] = false;
                      }
                    }
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 300),
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
                fixedSize: const Size(10, 50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
 */