import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:myfin/app/features/pages/add/widgets/currency_buttons.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileScreen(
      appBar: AppBar(),
      providers: [EmailAuthProvider()],
      actions: [
        SignedOutAction((context) {
          Navigator.pushReplacementNamed(context, '/sign-in');
        }),
      ],
      children: [
        const SizedBox(height: 20),
        Text(
          AppLocalizations.of(context).currency,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CurrencyButtons(),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
