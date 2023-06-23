import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myfin/App/features/pages/exchange/pages/exchange_rates_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:myfin/App/features/auth/pages/user_profile.dart';
import 'package:myfin/app/domain/theme/colors.dart';
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
              children: [
                Text(
                  'FinBud.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                ),
                Text(
                  AppLocalizations.of(context).subtitle,
                  style: const TextStyle(fontSize: 14),
                )
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: accentColors(),
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
              color: accentColors(),
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
              color: accentColors(),
            ),
            title: Text(AppLocalizations.of(context).yearlysummaries,
                style: GoogleFonts.lato()),
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
              color: accentColors(),
            ),
            applicationIcon: const Icon(Icons.info),
            applicationName: 'FinBud - Kontrola finansów',
            applicationVersion: '1.0.6',
            applicationLegalese: 'Patryk Strączek',
            child: Text(AppLocalizations.of(context).info,
                style: GoogleFonts.lato()),
          ),
        ],
      ),
    );
  }
}
