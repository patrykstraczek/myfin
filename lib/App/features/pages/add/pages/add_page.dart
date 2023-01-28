import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:myfin/App/domain/repositories/incomes_repository.dart';
import 'package:myfin/App/domain/repositories/spendings_repository.dart';
import 'package:myfin/App/features/pages/add/cubit/add_page_cubit.dart';
import 'package:myfin/App/features/pages/add/widgets/icons_body.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddPage extends StatefulWidget {
  const AddPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

bool spendingSelected = true;
String? name;
String? value;
var spendingIcon = 0xe516;
var incomeIcon = 0xe047;
int iconSelected = 0;
String text = text.replaceAll(",", ".");

DateTime selectedDate = DateTime.now();

List<Map<String, dynamic>> spendingsItems = <Map<String, dynamic>>[
  <String, dynamic>{'icon': Icons.remove},
  <String, dynamic>{'icon': Icons.drive_eta},
  <String, dynamic>{'icon': Icons.food_bank},
  <String, dynamic>{'icon': Icons.home},
  <String, dynamic>{'icon': Icons.sports_esports},
];

List<Map<String, dynamic>> incomesItems = <Map<String, dynamic>>[
  <String, dynamic>{'icon': Icons.add},
  <String, dynamic>{'icon': Icons.work},
  <String, dynamic>{'icon': Icons.person},
  <String, dynamic>{'icon': Icons.card_giftcard},
  <String, dynamic>{'icon': Icons.currency_exchange},
];

class _AddPageState extends State<AddPage> {
  void checkOption(int index) {
    setState(() {
      iconSelected = index;
    });
  }

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
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              actions: [
                BlocProvider(
                  create: (context) => AddPageCubit(
                    SpendingsRepository(),
                    IncomesRepository(),
                  ),
                  child: BlocBuilder<AddPageCubit, AddPageState>(
                    builder: (context, state) {
                      return IconButton(
                        onPressed: value == null || name == null
                            ? null
                            : () {
                                if (spendingSelected == true) {
                                  [
                                    context.read<AddPageCubit>().addSpending(
                                          name!,
                                          value!.replaceAll(",", "."),
                                          selectedDate,
                                          spendingIcon,
                                        )
                                  ];
                                }
                                if (spendingSelected == false) {
                                  [
                                    context.read<AddPageCubit>().addIncome(
                                          name!,
                                          value!.replaceAll(",", "."),
                                          selectedDate,
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
                AppLocalizations.of(context).add,
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
// choose spending/income
                    TextButton(
                      onPressed: () {
                        setState(() {
                          spendingSelected = true;
                        });
                      },
                      child: Text(
                        AppLocalizations.of(context).spending,
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
                          AppLocalizations.of(context).income,
                          style: GoogleFonts.lato(
                            color:
                                spendingSelected ? Colors.grey : Colors.amber,
                            fontSize: 16,
                          ),
                        )),
                  ],
                ),
// set name
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
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: AppLocalizations.of(context).hintName,
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(200, 218, 216, 216),
                      ),
                    ),
                  ),
                ),
// set value
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
                    onSubmitted: (text) {
                      FocusScope.of(context).unfocus();
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: AppLocalizations.of(context).hintValue,
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(200, 218, 216, 216),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
// set date
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    AppLocalizations.of(context).date,
                    style: GoogleFonts.lato(
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: _MyCalendar(
                    onDateChanged: (newValue) {
                      setState(() {
                        selectedDate = newValue!;
                      });
                    },
                    selectedDateFormatted: DateFormat.yMMMEd(
                            AppLocalizations.of(context).dateFormat)
                        .format(selectedDate),
                  ),
                ),
                const SizedBox(height: 50),
// set icon
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    AppLocalizations.of(context).icon,
                    style: GoogleFonts.lato(
                      color: Colors.white,
                    ),
                  ),
                ),
                spendingSelected
                    ? Container(
                        padding: const EdgeInsets.all(32),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            for (int i = 0; i < spendingsItems.length; i++)
                              IconsBody(
                                icon: spendingsItems[i]['icon'] as IconData,
                                onTap: () {
                                  checkOption(i + 1);
                                  setState(() {
                                    spendingIcon =
                                        (spendingsItems[i]['icon'] as IconData)
                                            .codePoint;
                                  });
                                },
                                selected: i + 1 == iconSelected,
                              )
                          ],
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.all(32),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            for (int i = 0; i < incomesItems.length; i++)
                              IconsBody(
                                icon: incomesItems[i]['icon'] as IconData,
                                onTap: () {
                                  checkOption(i + 1);
                                  setState(() {
                                    incomeIcon =
                                        (incomesItems[i]['icon'] as IconData)
                                            .codePoint;
                                  });
                                },
                                selected: i + 1 == iconSelected,
                              )
                          ],
                        ),
                      )
              ],
            ),
          );
        },
      ),
    );
  }
}

class _MyCalendar extends StatelessWidget {
  const _MyCalendar({
    Key? key,
    required this.onDateChanged,
    this.selectedDateFormatted,
  }) : super(key: key);

  final Function(DateTime?) onDateChanged;
  final String? selectedDateFormatted;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final selectedDate = await showDatePicker(
            currentDate: DateTime.now(),
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(
              const Duration(days: 365),
            ),
            lastDate: DateTime.now());
        onDateChanged(selectedDate);
      },
      child: Text(
        selectedDateFormatted ??
            DateFormat.yMMMEd(AppLocalizations.of(context).dateFormat).format(
              DateTime.now(),
            ),
      ),
    );
  }
}
