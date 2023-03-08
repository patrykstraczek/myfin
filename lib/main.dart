import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myfin/App/app.dart';
import 'package:myfin/app/injection_container.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  configureDependencies();
  runApp(const MyApp());
}
