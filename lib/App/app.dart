import 'package:flutter/material.dart';
import 'package:myfin/App/features/auth/pages/auth_gate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:myfin/App/domain/theme/theme_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyFin - Moje Finanse',
      theme: darkMode ? darkTheme : lightTheme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('pl'), // Polish
      ],
      home: const AuthGate(),
    );
  }
}