import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfin/App/features/auth/pages/login_page.dart';
import 'package:myfin/App/features/home/pages/home_page.dart';
import 'package:myfin/App/features/theme/theme_data.dart';
import 'package:myfin/app/cubit/root_cubit.dart';

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
      theme: iconBool ? darkTheme : lightTheme,
      home: const RootPage(),
    );
  }
}

class RootPage extends StatelessWidget {
  const RootPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RootCubit()..start(),
      child: BlocBuilder<RootCubit, RootState>(
        builder: (context, state) {
          final user = state.user;
          if (user == null) {
            return LoginPage();
          }
          return HomePage(user: user);
        },
      ),
    );
  }
}
