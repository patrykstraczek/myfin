import 'package:flutter/material.dart';
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
          title: const Text('Dodaj'),
          centerTitle: true,
          backgroundColor: Colors.grey[900],
          bottom: const TabBar(
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
