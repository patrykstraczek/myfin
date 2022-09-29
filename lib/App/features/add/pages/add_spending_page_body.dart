/* import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:myfin/App/features/add/widgets/calendar.dart';

class AddSpendingPageBody extends StatefulWidget {
  AddSpendingPageBody({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  final valueController = TextEditingController();

  @override
  State<AddSpendingPageBody> createState() => _AddSpendingPageBodyState();
}

List<bool> isSelected = List.generate(5, (_) => false);
List<bool> spendingSelected = [true, false];

var spendingName = '';
double? spendingValue;
DateTime? actualDate;

class _AddSpendingPageBodyState extends State<AddSpendingPageBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: ListView(
        children: [
          Column(
            children: [
              ToggleButtons(
                  borderWidth: 100,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'Wydatek',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'Przychód',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                  color: Colors.white,
                  selectedColor: Colors.teal,
                  fillColor: Colors.transparent,
                  renderBorder: false,
                  isSelected: spendingSelected,
                  onPressed: (int newIndex) {
                    setState(
                      () {
                        for (int index = 0;
                            index < spendingSelected.length;
                            index++) {
                          if (index == newIndex) {
                            spendingSelected[index] = true;
                          } else {
                            spendingSelected[index] = false;
                          }
                        }
                      },
                    );
                  })
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: widget.nameController,
              textCapitalization: TextCapitalization.sentences,
              style: const TextStyle(color: Colors.white),
              onChanged: (newValue) {
                setState(() {
                  spendingName = newValue;
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
                  spendingValue = double.parse(newValue);
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
                  Icon(Icons.shopping_cart),
                  Icon(Icons.local_gas_station),
                  Icon(Icons.flight_takeoff),
                  Icon(Icons.home),
                  Icon(Icons.sports_esports),
                ],
                color: Colors.white,
                selectedColor: Colors.red,
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
                    .collection('spendings')
                    .add({
                  'spendingName': spendingName,
                  'spendingValue': spendingValue,
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