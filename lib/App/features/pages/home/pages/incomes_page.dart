import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:myfin/App/domain/repositories/incomes_repository.dart';
import 'package:myfin/App/features/pages/home/cubit/incomes/incomes_cubit.dart';

class IncomesPage extends StatelessWidget {
  const IncomesPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => IncomesCubit(IncomesRepository())..start(),
        child: BlocBuilder<IncomesCubit, IncomesState>(
          builder: (context, state) {
            state.docs;

            if (state.errorMessage.isNotEmpty) {
              return Center(
                  child: Text('Something went wrong ${state.errorMessage}'));
            }

            if (state.isLoading) {
              return const Center(child: Text(''));
            }

            final incomesModels = state.docs;

            return ListView(
              children: [
                for (final incomeModel in incomesModels) ...[
                  Dismissible(
                    key: ValueKey(incomeModel.id),
                    background: const DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.black,
                      ),
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
                    onDismissed: (direction) {
                      context
                          .read<IncomesCubit>()
                          .remove(documentID: incomeModel.id);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Colors.white12,
                        ),
                        child: ListTile(
                          leading: Icon(
                            IconData(incomeModel.selectedIncomesIcon,
                                fontFamily: 'materialIcons'),
                            color: Colors.white54,
                          ),
                          title: Text(
                            incomeModel.incomeName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          subtitle: Text(DateFormat.yMMMEd()
                              .format(incomeModel.incomeDate)),
                          trailing: Text(
                            '${incomeModel.incomeValue}zł',
                            style: const TextStyle(
                              color: Colors.green,
                            ),
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
