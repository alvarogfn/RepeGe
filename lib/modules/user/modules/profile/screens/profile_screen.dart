import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repege/components/headline.dart';
import 'package:repege/modules/authentication/services/auth_service.dart';
import 'package:repege/modules/user/modules/profile/components/profile_form_field.dart';
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
  void initState() {
    super.initState();

    final user = context.read<AuthService>().user;

    if (user == null) return;

    form = ProfileFormModel(email: user.email, username: user.username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: Consumer<AuthService>(
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
                child: Column(
                  children: [
                    const Headline(
                      'Dados Pessoais',
                      fontSize: 20,
                      padding: EdgeInsets.all(10),
                    ),
                    ProfileFormField(
                      label: 'Usuário',
                      readOnly: true,
                      controller: form.username,
                    ),
                    ProfileFormField(
                      label: 'Email',
                      controller: form.email,
                      readOnly: true,
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
