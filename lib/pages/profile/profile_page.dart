import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repege/components/organism/avatar_wallpaper.dart';
import 'package:repege/models/user.dart';
import 'package:repege/services/auth_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: Consumer<AuthService>(
        builder: ((context, service, child) {
          final User user = service.user!;
          return Column(
            children: [
              AvatarWallpaper(image: user.avatar),
              Input(
                label: 'username',
                initialValue: user.username,
                readOnly: true,
              ),
            ],
          );
        }),
      ),
    );
  }
}
