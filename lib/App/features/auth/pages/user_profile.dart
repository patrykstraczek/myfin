import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileScreen(
      appBar: AppBar(),
      providerConfigs: const [
        EmailProviderConfiguration(),
        GoogleProviderConfiguration(
          clientId: '...',
        ),
      ],
      actions: [
        SignedOutAction(
          (context) {
            Navigator.of(context).pop();
          },
        ),
      ],
      avatarSize: 100,
    );
  }
}
