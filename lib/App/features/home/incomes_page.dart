import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
      backgroundColor: const Color.fromARGB(255, 3, 37, 39),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection('incomes').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: Text(''));
            }

            final documents = snapshot.data!.docs;

            return ListView(
              children: [
                for (final document in documents) ...[
                  Dismissible(
                    key: ValueKey(document.id),
                    background: const DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 3, 37, 39),
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
                    onDismissed: (_) {
                      FirebaseFirestore.instance
                          .collection('incomes')
                          .doc(document.id)
                          .delete();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        color: const Color.fromARGB(125, 238, 210, 145),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                document['name'],
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                document['income'].toString() + 'zł',
                                style: const TextStyle(color: Colors.white),
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
          }),
    );
  }
}
