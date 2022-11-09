import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:myfin/App/features/add/widgets/calendar.dart';

class AddPage extends StatefulWidget {
  const AddPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

List<bool> isSelected = List.generate(5, (_) => false);
var spendingSelected = true;
var incomeIcon = 0xe047;
var spendingIcon = 0xe516;
var name = '';
var value = 0.0;

DateTime? selectedDate;

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (spendingSelected == true) ...[
            IconButton(
              onPressed: name.isEmpty || selectedDate == null || value == 0.0
                  ? null
                  : () {
                      Navigator.pop(context);
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc('2SHBQGWMo4JZleshrllF')
                          .collection('spendings')
                          .add({
                        'icon': spendingIcon,
                        'spendingName': name,
                        'spendingValue': value,
                        'date': selectedDate,
                      });
                    },
              icon: const Icon(
                Icons.check,
              ),
            ),
          ],
          if (spendingSelected == false) ...[
            IconButton(
              onPressed: name.isEmpty || selectedDate == null || value == 0.0
                  ? null
                  : () {
                      Navigator.pop(context);
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc('2SHBQGWMo4JZleshrllF')
                          .collection('incomes')
                          .add({
                        'icon': incomeIcon,
                        'incomeName': name,
                        'incomeValue': value,
                        'date': selectedDate,
                      });
                    },
              icon: const Icon(
                Icons.check,
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
              onChanged: (newValue) {
                setState(() {
                  name = newValue;
                });
              },
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
              onChanged: (newValue) {
                setState(() {
                  value = newValue as double;
                });
              },
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
              'Oznaczenie:',
              style: GoogleFonts.lato(
                color: Colors.white,
              ),
            ),
          ),
          Column(
            children: [
              spendingSelected
                  ? ToggleButtons(
                      children: const [
                        Icon(Icons.remove),
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
                          for (int index = 0;
                              index < isSelected.length;
                              index++) {
                            if (index == newIndex) {
                              isSelected[index] = true;
                            } else {
                              isSelected[index] = false;
                            }
                          }
                        });
                      },
                    )
                  : ToggleButtons(
                      children: const [
                        Icon(Icons.add),
                        Icon(Icons.work),
                        Icon(Icons.local_post_office),
                        Icon(Icons.legend_toggle),
                        Icon(Icons.person),
                      ],
                      color: Colors.white,
                      splashColor: Colors.transparent,
                      selectedColor: Colors.green,
                      fillColor: Colors.transparent,
                      renderBorder: false,
                      isSelected: isSelected,
                      onPressed: (int newIndex) {
                        setState(() {
                          for (int index = 0;
                              index < isSelected.length;
                              index++) {
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
          spendingSelected
              ? TextButton(
                  onPressed: () {
                    setState(() {
                      spendingIcon = 0xe516;
                    });
                  },
                  child: const Icon(Icons.remove),
                )
              : TextButton(
                  onPressed: () {
                    setState(() {
                      incomeIcon = 0xe047;
                    });
                  },
                  child: const Icon(Icons.add),
                ),
        ],
      ),
    );
  }
}
