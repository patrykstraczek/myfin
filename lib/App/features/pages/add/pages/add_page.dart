import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:myfin/App/domain/icons.dart';
import 'package:myfin/App/features/pages/add/cubit/add_page_cubit.dart';
import 'package:myfin/App/features/pages/add/widgets/icons_body.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:myfin/App/widgets/calendar_widget.dart';
import 'package:myfin/app/features/pages/home/pages/home_page.dart';
import 'package:myfin/app/injection_container.dart';

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

class _AddPageState extends State<AddPage> {
  void checkOption(int index) {
    setState(() {
      iconSelected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return getIt<AddPageCubit>();
      },
      child: BlocBuilder<AddPageCubit, AddPageState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                BlocProvider(
                  create: (context) {
                    return getIt<AddPageCubit>();
                  },
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
                          color: isDarkMode
                              ? spendingSelected
                                  ? const Color(0xff673ab7)
                                  : Colors.grey
                              : spendingSelected
                                  ? const Color(0xfff39c12)
                                  : Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
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
                            color: isDarkMode
                                ? spendingSelected
                                    ? Colors.grey
                                    : const Color(0xff673ab7)
                                : spendingSelected
                                    ? Colors.grey
                                    : const Color(0xfff39c12),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
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
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: AppLocalizations.of(context).hintName,
                      hintStyle: const TextStyle(),
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
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (text) {
                      FocusScope.of(context).unfocus();
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: AppLocalizations.of(context).hintValue,
                      hintStyle: const TextStyle(),
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
                    style: GoogleFonts.lato(),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: MyCalendar(
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
                    style: GoogleFonts.lato(),
                  ),
                ),
                spendingSelected
                    ? Container(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            for (int i = 0; i < spendingIcons.length; i++)
                              IconsBody(
                                icon: spendingIcons[i]['icon'] as IconData,
                                onTap: () {
                                  checkOption(i + 1);
                                  setState(() {
                                    spendingIcon =
                                        (spendingIcons[i]['icon'] as IconData)
                                            .codePoint;
                                  });
                                },
                                selected: i + 1 == iconSelected,
                              )
                          ],
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            for (int i = 0; i < incomeIcons.length; i++)
                              IconsBody(
                                icon: incomeIcons[i]['icon'] as IconData,
                                onTap: () {
                                  checkOption(i + 1);
                                  setState(() {
                                    incomeIcon =
                                        (incomeIcons[i]['icon'] as IconData)
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
