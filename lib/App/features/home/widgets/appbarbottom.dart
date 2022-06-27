import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myfin/App/features/home/cubit/home_cubit.dart';
import 'package:myfin/App/features/home/pages/home_page.dart';

class AppBarBottomWidget extends StatelessWidget {
  const AppBarBottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      toolbarHeight: 250,
      bottom: PreferredSize(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Color.fromARGB(255, 174, 152, 100),
            ),
            alignment: Alignment.topCenter,
            height: 194.0,
            child: Column(children: [
              Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'Stan:',
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              const SizedBox(height: 10),
              Text(
                '$balanceThisMonth',
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              currentIndex == 0
                  ? BlocProvider(
                      create: (context) => HomeCubit()..start(),
                      child: BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          state.documents;

                          if (state.errorMessage.isNotEmpty) {
                            return Center(
                                child: Text(
                                    'Something went wrong ${state.errorMessage}'));
                          }

                          if (state.isLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          final documents = state.documents;

                          for (final doc in documents) {
                            [spendingsSum += (doc['spendingValue'])];
                          }

                          return DataTable(
                              columnSpacing: 80,
                              headingRowHeight: 25,
                              dataRowHeight: 20,
                              columns: const [
                                DataColumn(label: Text('Okres')),
                                DataColumn(label: Text('Suma wydatków:'))
                              ],
                              rows: [
                                DataRow(cells: [
                                  const DataCell(Text('Obecny miesiąc')),
                                  DataCell(
                                    Text(
                                      '$spendingsSum',
                                    ),
                                  )
                                ]),
                                const DataRow(cells: [
                                  DataCell(Text('Poprzedni miesiąc')),
                                  DataCell(Text('wydatków-1msc'))
                                ])
                              ]);
                        },
                      ),
                    )
                  : BlocProvider(
                      create: (context) => HomeIncomeCubit()..start(),
                      child: BlocBuilder<HomeIncomeCubit, HomeState>(
                        builder: (context, state) {
                          state.documents;

                          if (state.errorMessage.isNotEmpty) {
                            return Center(
                                child: Text(
                                    'Something went wrong ${state.errorMessage}'));
                          }

                          if (state.isLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          final documents = state.documents;

                          for (final doc in documents) {
                            [incomesSum += (doc['incomeValue'])];
                          }

                          return DataTable(
                              columnSpacing: 80,
                              headingRowHeight: 25,
                              dataRowHeight: 20,
                              columns: const [
                                DataColumn(label: Text('Okres')),
                                DataColumn(label: Text('Suma przychodów:'))
                              ],
                              rows: [
                                DataRow(cells: [
                                  const DataCell(Text('Obecny miesiąc')),
                                  DataCell(
                                    Text(
                                      '$incomesSum',
                                    ),
                                  )
                                ]),
                                const DataRow(cells: [
                                  DataCell(Text('Poprzedni miesiąc')),
                                  DataCell(Text('przychodów-1msc'))
                                ])
                              ]);
                        },
                      ),
                    )
            ]),
          ),
          preferredSize: const Size.fromHeight(0)),
    );
  }
}
