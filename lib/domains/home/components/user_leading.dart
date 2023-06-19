import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";
import "package:repege/config/routes_name.dart";
import "package:repege/domains/authentication/services/auth_service.dart";

class UserLeading extends StatelessWidget {
  const UserLeading({
    super.key,
  });

  Future<void> navigateToProfile(BuildContext context) async {
    context.pushNamed(RoutesName.profile.name);
  }

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
              onTap: () => navigateToProfile(context),
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

    return const AssetImage("assets/images/default_profile_picture.png");
  }
}
