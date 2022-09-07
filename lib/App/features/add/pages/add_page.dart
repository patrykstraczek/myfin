import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myfin/App/features/add/pages/add_income_page_body.dart';
import 'package:myfin/App/features/add/pages/add_spending_page_body.dart';

class AddPage extends StatefulWidget {
  const AddPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              color: Colors.white,
              onPressed: () {
                spendingValue == null
                    ? null
                    : () {
                        Navigator.pop(context);
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc('2SHBQGWMo4JZleshrllF')
                            .collection('spendings')
                            .add({
                          'spendingName': spendingName,
                          'spendingValue': spendingValue,
                        });
                      };
              },
              icon: const Icon(Icons.check),
            ),
          ],
          title: Text(
            'Dodaj',
            style: GoogleFonts.lato(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.grey[900],
          bottom: const TabBar(
            labelColor: Colors.white,
            tabs: [
              Tab(text: 'Wydatek'),
              Tab(text: 'Przychód'),
            ],
          ),
        ),
        backgroundColor: Colors.grey[900],
        body: TabBarView(
          children: [
            AddSpendingPageBody(),
            AddIncomePageBody(),
          ],
        ),
      ),
    );
  }
}
