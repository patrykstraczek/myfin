import 'package:flutter/material.dart';
import 'package:myfin/App/features/pages/details/details_page.dart';
import 'package:myfin/app/features/pages/home/pages/home_page.dart';

import 'package:myfin/app/widgets/floating_action_button.dart';

class DailyReportsPage extends StatelessWidget {
  const DailyReportsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
        title: const Text('Marzec 2023'),
        centerTitle: true,
      ),
      floatingActionButton: MyFloatingActionButton(context),
      body: ListView(children: [
        Column(children: [
          Container(
            padding: const EdgeInsets.only(left: 10),
            margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            width: double.infinity,
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey[900] : Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(16)),
            ),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const DetailsPage()));
              },
              child: SizedBox(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          '20/03/2023',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          color: Colors.red,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                '-120 PLN',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                '+25 PLN',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ]),
      ]),
    );
  }

  
}
