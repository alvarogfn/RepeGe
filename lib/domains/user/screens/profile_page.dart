import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:repege/components/atoms/headline.dart";
import "package:repege/components/organism/avatar_wallpaper.dart";
import "package:repege/components/atoms/input.dart";
import "package:repege/domains/authentication/services/auth_service.dart";
import "package:repege/domains/authentication/services/user.dart";

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _Layout(builder: ((context, service, child) {
      final User user = service.user!;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AvatarWallpaper(image: user.avatar),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(children: [
              const Headline(
                "Dados Pessoais",
                fontSize: 20,
                padding: EdgeInsets.all(10),
              ),
              Input(
                label: "Usuário",
                initialValue: user.username,
                readOnly: true,
                margin: const EdgeInsets.symmetric(vertical: 10),
              ),
              Input(
                label: "Email",
                initialValue: user.email,
                readOnly: true,
                margin: const EdgeInsets.symmetric(vertical: 10),
              ),
            ]),
          ),
        ],
      );
    }));
  }
}

class _Layout extends StatelessWidget {
  const _Layout({required this.builder});

  final Widget Function(BuildContext, AuthService, Widget?) builder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Perfil")),
      body: Consumer<AuthService>(
        builder: builder,
      ),
    );
  }
}
