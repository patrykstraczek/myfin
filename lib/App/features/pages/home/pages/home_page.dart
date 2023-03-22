import 'package:flutter/material.dart';
import 'package:myfin/App/features/pages/add/pages/add_page.dart';
import 'package:myfin/App/widgets/drawer_widget.dart';
import 'package:myfin/app/domain/theme/theme_provider.dart';
import 'package:myfin/App/features/pages/all_items/pages/all_items_page.dart';
import 'package:myfin/App/features/pages/details/details_page.dart';

import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

bool isDarkMode = true;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
        title: const Text('Raporty'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: isDarkMode
                ? const Icon(Icons.nights_stay)
                : const Icon(Icons.wb_sunny),
            onPressed: () {
              setState(() {
                isDarkMode = !isDarkMode;
              });
              if (isDarkMode) {
                // switch to dark theme
                Provider.of<ThemeProvider>(context, listen: false)
                    .setDarkMode();
              } else {
                // switch to light theme
                Provider.of<ThemeProvider>(context, listen: false)
                    .setLightMode();
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[300],
        foregroundColor: Colors.black,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => const AddPage(),
          ));
        },
        child: const Icon(Icons.add),
      ),
      body: Column(children: [
        const _AllHistoryItem(),
        Expanded(
          child: ListView(children: const [
            _HomePageBody(),
            _HomePageBody(),
            _HomePageBody(),
            _HomePageBody(),
            _HomePageBody(),
            _HomePageBody(),
            _HomePageBody(),
            _HomePageBody(),
          ]),
        )
      ]),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: isDarkMode
              ? const Color.fromARGB(255, 148, 112, 4)
              : Colors.amber,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const DetailsPage()));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: const [
                  Text(
                    '10/10/2022',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text(
                    '-120 PLN',
                  ),
                  SizedBox(height: 10),
                  Text(
                    '+25 PLN',
                  ),
                ],
              ),
            ],
          ),
        ),
      )
    ]);
  }
}

class _AllHistoryItem extends StatelessWidget {
  const _AllHistoryItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          color: isDarkMode ? Colors.grey[900] : Colors.white,
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const AllItemsPage()));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Sprawdź całą historię',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      )
    ]);
  }
}
