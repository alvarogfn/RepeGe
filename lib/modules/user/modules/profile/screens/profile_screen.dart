import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repege/components/headline.dart';
import 'package:repege/modules/authentication/services/auth_service.dart';
import 'package:repege/modules/user/modules/profile/model/profile_form_model.dart';
import 'package:repege/modules/user/services/user.dart';
import 'package:repege/modules/user/modules/profile/components/profile_picture.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileFormModel form = ProfileFormModel();

  @override
  Widget build(BuildContext context) {
    return _Layout(
      builder: ((context, service, child) {
        final User user = service.user!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProfilePicture(
              image: user.avatar,
              onChanged: (file) => form.profilePicture = file,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(children: [
                const Headline(
                  'Dados Pessoais',
                  fontSize: 20,
                  padding: EdgeInsets.all(10),
                ),
                TextFormField(
                  decoration: const InputDecoration(label: Text('Usuário')),
                  readOnly: true,
                  controller: form.username,
                ),
                TextFormField(
                  decoration: const InputDecoration(label: Text('Email')),
                  controller: form.email,
                  readOnly: true,
                ),
              ]),
            ),
          ],
        );
      }),
    );
  }
}

class _Layout extends StatelessWidget {
  const _Layout({required this.builder});

  final Widget Function(BuildContext, AuthService, Widget?) builder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: Consumer<AuthService>(
        builder: builder,
      ),
    );
  }
}
