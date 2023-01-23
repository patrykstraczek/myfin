import 'package:flutter/material.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moje konta'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: Colors.green,
                ),
                child: const ListTile(
                  title: Text('Jakieś konto'),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Dodaj Konto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
