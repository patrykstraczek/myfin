import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myfin/App/features/pages/auth/pages/user_profile.dart';
import 'package:myfin/App/features/pages/exchange/pages/exchange_rates_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
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
              color: Colors.white54,
            ),
            title: Text(AppLocalizations.of(context).profile,
                style: GoogleFonts.lato(
                  color: Colors.white,
                )),
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
              color: Colors.white54,
            ),
            title: Text(AppLocalizations.of(context).exchangeRates,
                style: GoogleFonts.lato(
                  color: Colors.white,
                )),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const ExchangeRatesPage(),
                ),
              );
            },
          ),
          const Divider(color: Colors.white),
          AboutListTile(
            icon: const Icon(
              Icons.info,
              color: Colors.white54,
            ),
            applicationIcon: const Icon(Icons.info),
            applicationName: 'MyFin - Moje Finanse',
            applicationVersion: 'ver. 0.1',
            applicationLegalese: 'Patryk Strączek',
            child: Text(AppLocalizations.of(context).info,
                style: GoogleFonts.lato(
                  color: Colors.white,
                )),
          ),
        ],
      ),
    );
  }
}