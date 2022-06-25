import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfin/App/features/home/cubit/incomes_cubit.dart';

class IncomesPage extends StatefulWidget {
  const IncomesPage({
    Key? key,
  }) : super(key: key);

  @override
  State<IncomesPage> createState() => _IncomesPage();
}

class _IncomesPage extends State<IncomesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocProvider(
        create: (context) => IncomesCubit()..start(),
        child: BlocBuilder<IncomesCubit, IncomesState>(
          builder: (context, state) {
            state.documents;

            if (state.errorMessage.isNotEmpty) {
              return Center(
                  child: Text('Something went wrong ${state.errorMessage}'));
            }

            if (state.isLoading) {
              return const Center(child: Text(''));
            }

            final documents = state.documents;

            return ListView(
              children: [
                for (final document in documents) ...[
                  Dismissible(
                    key: ValueKey(document.id),
                    background: const DecoratedBox(
                      decoration: BoxDecoration(color: Colors.black),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 32.0),
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    confirmDismiss: (direction) async {
                      return direction == DismissDirection.startToEnd;
                    },
                    onDismissed: (_) {
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc('2SHBQGWMo4JZleshrllF')
                          .collection('incomes')
                          .doc(document.id)
                          .delete();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.white12,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.monetization_on,
                                color: Colors.white54,
                              ),
                              Text(
                                document['incomeName'],
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                document['incomeValue'].toString() + 'zł',
                                style: const TextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
