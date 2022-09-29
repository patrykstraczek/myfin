import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myfin/App/features/auth/pages/user_profile.dart';

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
            title: Text('Moje konto',
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
          const Divider(color: Colors.white),
          AboutListTile(
            icon: const Icon(
              Icons.info,
              color: Colors.white54,
            ),
            child: Text('Informacje',
                style: GoogleFonts.lato(
                  color: Colors.white,
                )),
            applicationIcon: const Icon(Icons.info),
            applicationName: 'MyFin - Moje Finanse',
            applicationVersion: 'ver. 0.1',
            applicationLegalese: 'Patryk Strączek',
          ),
        ],
      ),
    );
  }
}
