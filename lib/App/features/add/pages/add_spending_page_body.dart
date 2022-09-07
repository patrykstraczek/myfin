import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfin/App/features/add/widgets/calendar.dart';

class AddSpendingPageBody extends StatefulWidget {
  AddSpendingPageBody({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  final valueController = TextEditingController();

  @override
  State<AddSpendingPageBody> createState() => _AddSpendingPageBodyState();
}

List<bool> isSelected = List.generate(5, (_) => false);

var spendingName = '';
double? spendingValue;
DateTime actualDate = DateTime.now();

class _AddSpendingPageBodyState extends State<AddSpendingPageBody> {
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: const MyCalendar(),
          ),
          const SizedBox(height: 100),
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
          const SizedBox(height: 100),
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
