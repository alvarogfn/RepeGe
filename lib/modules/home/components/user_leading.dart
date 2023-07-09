import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/config/routes_name.dart';
import 'package:repege/modules/authentication/services/auth_service.dart';

class UserLeading extends StatelessWidget {
  const UserLeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        final user = authService.user;

        if (user == null) return const SizedBox();

        return Row(
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () => context.pushNamed(RoutesName.profile.name),
              child: CircleAvatar(backgroundImage: avatar(user.avatarURL)),
            ),
            const SizedBox(width: 15),
            Text(
              user.username,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ],
        );
      },
    );
  }

  ImageProvider avatar(String? avatarURL) {
    if (avatarURL != null) {
      return NetworkImage(avatarURL);
    }

    return const AssetImage('assets/images/default_profile_picture.png');
  }
}
