import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:myfin/App/core/enums.dart';
import 'package:myfin/App/domain/models/incomes_model.dart';
import 'package:myfin/App/domain/remote_data_sources/incomes_data_source.dart';
import 'package:myfin/App/domain/repositories/incomes_repository.dart';
import 'package:myfin/App/features/pages/home/cubit/incomes/incomes_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IncomesPage extends StatelessWidget {
  const IncomesPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return IncomesCubit(IncomesRepository(
            FirebaseIncomeDataSource(),
          ))
            ..start();
        },
        child: BlocBuilder<IncomesCubit, IncomesState>(
          builder: (context, state) {
            switch (state.status) {
              case Status.initial:
                return const Center(
                  child: Text(''),
                );
              case Status.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );

              case Status.success:
                return ListView(children: [
                  for (final income in state.docs)
                    _IncomeItemWidget(model: income)
                ]);
              case Status.error:
                return Center(
                  child: Text(
                    state.errorMessage ?? 'Unknown error',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}

class _IncomeItemWidget extends StatelessWidget {
  const _IncomeItemWidget({Key? key, required this.model}) : super(key: key);

  final IncomesModel model;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(model.id),
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
        context.read<IncomesCubit>().remove(documentID: model.id);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Colors.white12,
          ),
          child: ListTile(
            leading:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(
                IconData(model.selectedIncomesIcon,
                    fontFamily: 'materialIcons'),
                color: Colors.white54,
              ),
            ]),
            title: Text(
              model.incomeName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            subtitle: Text(
              DateFormat.yMMMEd(AppLocalizations.of(context).dateFormat)
                  .format(model.incomeDate),
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
            trailing: Text(
              '${model.incomeValue}  PLN',
              style: const TextStyle(
                color: Colors.green,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
