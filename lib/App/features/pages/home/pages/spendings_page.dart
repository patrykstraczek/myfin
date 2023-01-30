import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:myfin/App/domain/remote_data_sources/spending_data_source.dart';
import 'package:myfin/App/domain/repositories/spendings_repository.dart';
import 'package:myfin/App/features/pages/home/cubit/spendings/spendings_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SpendingsPage extends StatelessWidget {
  const SpendingsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            SpendingsCubit(SpendingsRepository(FirebaseSpendingsDataSource()))
              ..start(),
        child: BlocBuilder<SpendingsCubit, SpendingsState>(
            builder: (context, state) {
          state.docs;

          if (state.errorMessage.isNotEmpty) {
            return Center(child: Text(state.errorMessage.toString()));
          }

          if (state.isLoading) {
            return const Center(child: Text(''));
          }

          final spendingsModels = state.docs;

          return ListView(
            children: [
              for (final spendingModel in spendingsModels) ...[
                Dismissible(
                  key: ValueKey(spendingModel.id),
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
                        .read<SpendingsCubit>()
                        .remove(documentID: spendingModel.id);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.white12,
                      ),
                      child: ListTile(
                        leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                IconData(spendingModel.selectedSpendingIcon,
                                    fontFamily: 'materialIcons'),
                                color: Colors.white54,
                              ),
                            ]),
                        title: Text(
                          spendingModel.spendingName,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          DateFormat.yMMMEd(
                                  AppLocalizations.of(context).dateFormat)
                              .format(spendingModel.spendingDate),
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        trailing: Text(
                          '${spendingModel.spendingValue}  PLN',
                          style: const TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          );
        }),
      ),
    );
  }
}
