import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:myfin/App/core/enums.dart';
import 'package:myfin/App/domain/models/spendings_model.dart';
import 'package:myfin/App/features/pages/home/cubit/spendings/spendings_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:myfin/app/injection_container.dart';

class SpendingsPage extends StatelessWidget {
  const SpendingsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return getIt<SpendingsCubit>()..start();
        },
        child: BlocBuilder<SpendingsCubit, SpendingsState>(
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
                return ListView(
                  children: [
                    for (final spending in state.docs)
                      _SpendingItemWidget(model: spending)
                  ],
                );
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

class _SpendingItemWidget extends StatelessWidget {
  const _SpendingItemWidget({Key? key, required this.model}) : super(key: key);

  final SpendingsModel model;

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
        context.read<SpendingsCubit>().remove(documentID: model.id);
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
                IconData(model.selectedSpendingIcon,
                    fontFamily: 'materialIcons'),
                color: Colors.white54,
              ),
            ]),
            title: Text(
              model.spendingName,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            subtitle: Text(
              DateFormat.yMMMEd(AppLocalizations.of(context).dateFormat)
                  .format(model.spendingDate),
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
            trailing: Text(
              '${model.spendingValue}  PLN',
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
