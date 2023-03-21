import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myfin/App/features/auth/pages/user_profile.dart';
import 'package:myfin/App/features/pages/exchange/pages/exchange_rates_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:myfin/app/features/pages/home/pages/home_page.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      //backgroundColor: isDarkMode ? Colors.black : Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey[900],
            ),
            child: Text(
              'MyFin',
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                color: Colors.amber,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.person,
            ),
            title: Text(AppLocalizations.of(context).profile,
                style: GoogleFonts.lato()),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const UserProfile(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.moving,
            ),
            title: Text(AppLocalizations.of(context).exchangeRates,
                style: GoogleFonts.lato()),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const ExchangeRatesPage(),
                ),
              );
            },
          ),
          const Divider(),
          AboutListTile(
            icon: const Icon(
              Icons.info,
            ),
            applicationIcon: const Icon(Icons.info),
            applicationName: 'MyFin - Moje Finanse',
            applicationVersion: 'ver. 0.1',
            applicationLegalese: 'Patryk Strączek',
            child: Text(AppLocalizations.of(context).info,
                style: GoogleFonts.lato()),
          ),
        ],
      ),
    );
  }
}
