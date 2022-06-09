import 'package:flutter/material.dart';

@override
Widget build(BuildContext context) {
  return AddPage();
}

class AddPage extends StatelessWidget {
  AddPage({
    Key? key,
  }) : super(key: key);

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dodaj wartość'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 174, 152, 100),
      ),
      backgroundColor: const Color.fromARGB(255, 3, 37, 39),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Nazwa',
                hintStyle: TextStyle(
                  color: Color.fromARGB(200, 218, 216, 216),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Kwota',
                hintStyle: TextStyle(
                  color: Color.fromARGB(200, 218, 216, 216),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
