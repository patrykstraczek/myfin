import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myfin/App/features/pages/exchange/pages/exchange_rates_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:myfin/App/features/auth/pages/user_profile.dart';
import 'package:myfin/app/features/pages/summaries/yearly_summaries_page.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key, required this.isDarkMode}) : super(key: key);

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'MyFin.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: isDarkMode
                  ? const Color(0xff673ab7)
                  : const Color(0xfff5b041),
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
            leading: Icon(
              Icons.currency_exchange,
              color: isDarkMode
                  ? const Color(0xff673ab7)
                  : const Color(0xfff5b041),
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
          ListTile(
            leading: Icon(
              Icons.calendar_month,
              color: isDarkMode
                  ? const Color(0xff673ab7)
                  : const Color(0xfff5b041),
            ),
            title: Text('Historia', style: GoogleFonts.lato()),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const YearlySummariesPage(),
                ),
              );
            },
          ),
          const Divider(),
          AboutListTile(
            icon: Icon(
              Icons.info,
              color: isDarkMode
                  ? const Color(0xff673ab7)
                  : const Color(0xfff5b041),
            ),
            applicationIcon: const Icon(Icons.info),
            applicationName: 'MyFin - Moje Finanse',
            applicationVersion: '',
            applicationLegalese: 'Patryk Strączek',
            child: Text(AppLocalizations.of(context).info,
                style: GoogleFonts.lato()),
          ),
        ],
      ),
    );
  }
}
