import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:myfin/app/domain/theme/theme_provider.dart';
import 'package:myfin/app/features/auth/pages/sign_in_screen.dart';
import 'package:myfin/app/features/pages/home/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:myfin/app/core/currency_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
        ChangeNotifierProvider<CurrencyNotifier>(
          create: (_) {
            CurrencyNotifier currencyNotifier = CurrencyNotifier();
            currencyNotifier.loadCurrency();
            return currencyNotifier;
          },
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            initialRoute: FirebaseAuth.instance.currentUser == null
                ? '/sign-in'
                : '/home',
            routes: {
              '/sign-in': (context) {
                return const SignInPage();
              },
              '/home': (context) {
                return const HomePage();
              },
            },
            title: 'MyFin+',
            theme: themeProvider.getTheme(),
            localizationsDelegates: [
              FirebaseUILocalizations.delegate,
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'), // English
              Locale('pl'), // Polish
            ],
          );
        },
      ),
    );
  }
}
