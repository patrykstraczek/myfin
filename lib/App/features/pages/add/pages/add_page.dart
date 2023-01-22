import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:myfin/App/domain/repositories/incomes_repository.dart';
import 'package:myfin/App/domain/repositories/spendings_repository.dart';

import 'package:myfin/App/features/pages/add/cubit/add_page_cubit.dart';
import 'package:myfin/App/features/pages/add/widgets/calendar.dart';

class AddPage extends StatefulWidget {
  const AddPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

List<bool> isSelected = List.generate(5, (_) => false);
bool spendingSelected = true;
var incomeIcon = 0xe047;
var spendingIcon = 0xe516;
String? name;
String? value;

DateTime? selectedDate;

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddPageCubit(
        SpendingsRepository(),
        IncomesRepository(),
      ),
      child: BlocBuilder<AddPageCubit, AddPageState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                BlocProvider(
                  create: (context) => AddPageCubit(
                    SpendingsRepository(),
                    IncomesRepository(),
                  ),
                  child: BlocBuilder<AddPageCubit, AddPageState>(
                    builder: (context, state) {
                      return IconButton(
                        onPressed: value == null ||
                                selectedDate == null ||
                                name == null
                            ? null
                            : () {
                                if (spendingSelected == true) {
                                  [
                                    context.read<AddPageCubit>().addSpending(
                                          name!,
                                          value!,
                                          selectedDate!,
                                          spendingIcon,
                                        )
                                  ];
                                }
                                if (spendingSelected == false) {
                                  [
                                    context.read<AddPageCubit>().addIncome(
                                          name!,
                                          value!,
                                          selectedDate!,
                                          incomeIcon,
                                        )
                                  ];
                                }
                                Navigator.pop(context);
                              },
                        icon: const Icon(
                          Icons.check,
                        ),
                      );
                    },
                  ),
                ),
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
                            color:
                                spendingSelected ? Colors.grey : Colors.amber,
                            fontSize: 16,
                          ),
                        )),
                  ],
                ),
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
                        value = newValue;
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
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
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
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
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
                            children: const [
                              Icon(Icons.remove),
                              Icon(Icons.local_gas_station),
                              Icon(Icons.flight_takeoff),
                              Icon(Icons.home),
                              Icon(Icons.sports_esports),
                            ],
                          )
                        : ToggleButtons(
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
                            children: const [
                              Icon(Icons.add),
                              Icon(Icons.work),
                              Icon(Icons.local_post_office),
                              Icon(Icons.legend_toggle),
                              Icon(Icons.person),
                            ],
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
        },
      ),
    );
  }
}
