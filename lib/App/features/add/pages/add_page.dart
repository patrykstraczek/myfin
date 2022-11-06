import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:myfin/App/features/add/widgets/calendar.dart';

class AddPage extends StatefulWidget {
  AddPage({
    Key? key,
  }) : super(key: key);

  final nameController = TextEditingController();
  final valueController = TextEditingController();

  @override
  State<AddPage> createState() => _AddPageState();
}

List<bool> isSelected = List.generate(5, (_) => false);
var spendingSelected = true;

DateTime? selectedDate;

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (spendingSelected == true) ...[
            IconButton(
              onPressed: () {
                widget.valueController == null || selectedDate == null
                    ? null
                    : Navigator.pop(context);
                FirebaseFirestore.instance
                    .collection('users')
                    .doc('2SHBQGWMo4JZleshrllF')
                    .collection('spendings')
                    .add({
                  'spendingName': widget.nameController.text,
                  'spendingValue': double.parse(widget.valueController.text),
                  'date': selectedDate,
                });
                widget.valueController.clear();
                widget.nameController.clear();
              },
              icon: const Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ],
          if (spendingSelected == false) ...[
            IconButton(
              onPressed: () {
                widget.valueController == null || widget.nameController == null
                    ? null
                    : Navigator.pop(context);
                FirebaseFirestore.instance
                    .collection('users')
                    .doc('2SHBQGWMo4JZleshrllF')
                    .collection('incomes')
                    .add({
                  'incomeName': widget.nameController.text,
                  'incomeValue': double.parse(widget.valueController.text),
                  'date': selectedDate,
                });
                widget.valueController.clear();
                widget.nameController.clear();
              },
              icon: const Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ],
        ],
        title: Text(
          'Dodaj',
          style: GoogleFonts.lato(),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    spendingSelected = true;
                  });
                },
                child: Text(
                  'Wydatek',
                  style: GoogleFonts.lato(
                    color: spendingSelected ? Colors.amber : Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 100),
              TextButton(
                  onPressed: () {
                    setState(() {
                      spendingSelected = false;
                    });
                  },
                  child: Text(
                    'Przychód',
                    style: GoogleFonts.lato(
                      color: spendingSelected ? Colors.grey : Colors.amber,
                      fontSize: 16,
                    ),
                  )),
            ],
          ),
          /* Column(
            children: [
              const SizedBox(height: 20),
              ToggleButtons(
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 60,
                      ),
                      child: Text(
                        'Wydatek',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 60,
                      ),
                      child: Text(
                        'Przychód',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                  color: Colors.white,
                  fillColor: Colors.transparent,
                  splashColor: Colors.transparent,
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
          ), */
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: widget.nameController,
              textCapitalization: TextCapitalization.sentences,
              style: const TextStyle(color: Colors.white),
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
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
              style: const TextStyle(color: Colors.white),
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
                  selectedDate = newValue;
                });
              },
              selectedDateFormatted: selectedDate == null
                  ? null
                  : DateFormat.yMMMEd().format(selectedDate!),
            ),
          ),
          const SizedBox(height: 50),
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
                splashColor: Colors.transparent,
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
        ],
      ),
    );
  }
}
