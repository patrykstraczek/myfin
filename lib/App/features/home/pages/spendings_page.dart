import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfin/App/features/home/cubit/spendings/spendings_cubit.dart';

class SpendingsPage extends StatefulWidget {
  const SpendingsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SpendingsPage> createState() => _SpendingsPageState();
}

class _SpendingsPageState extends State<SpendingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: BlocProvider(
        create: (context) => SpendingsCubit()..start(),
        child: BlocBuilder<SpendingsCubit, SpendingsState>(
            builder: (context, state) {
          state.documents;

          if (state.errorMessage.isNotEmpty) {
            return const Center(child: Text('Something went wrong:'));
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
                  background: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                    ),
                    child: const Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 32.0),
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  confirmDismiss: (direction) async {
                    return direction == DismissDirection.endToStart;
                  },
                  onDismissed: (direction) {
                    context
                        .read<SpendingsCubit>()
                        .remove(documentID: document.id);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.white12,
                      ),
                      child: ListTile(
                        leading: const Icon(
                          Icons.remove,
                          color: Colors.white54,
                        ),
                        title: Text(
                          document['spendingName'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        trailing: Text(
                          document['spendingValue'].toString() + 'zł',
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
