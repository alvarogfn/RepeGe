import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repege/components/shared/form/picture_form_field.dart';
import 'package:repege/components/shared/full_screen_scroll.dart';
import 'package:repege/models/user.dart';
import 'package:repege/pages/utils/loading_page.dart';
import 'package:repege/services/auth_service.dart';
import 'package:repege/utils/if_prop.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? avatar;
  bool changes = false;
  User? user;
  bool loading = false;

  Future<User?> fetchUser() async {
    try {
      updateLoading(true);

      final authUser = Provider.of<AuthService>(context, listen: false);
      final fetchedUser = await User.get(authUser.user!.uid);

      setState(() => user = fetchedUser);

      return user;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
      return null;
    } finally {
      updateLoading(false);
    }
  }

  Future<void> _submitChanges() async {
    try {
      updateLoading(true);
      if (user == null) return;
      if (avatar != null) await user!.updateAvatar(avatar!);
      await fetchUser();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      updateLoading(false);
    }
  }

  updateLoading(bool newValue) {
    setState(() => loading = newValue);
  }

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const LoadingPage();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        actions: ifProp(changes, [
          IconButton(onPressed: _submitChanges, icon: const Icon(Icons.save)),
        ]),
      ),
      body: FullScreenScroll(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 20,
          ),
          child: Column(
            children: [
              PictureFormField(
                label: 'Foto de Perfil',
                initialValue: user!.avatarURL,
                onChange: (file) {
                  if (file != null) {
                    avatar = file;
                    setState(() => changes = true);
                  }
                },
              ),
              UserFormData(user: user!),
            ],
          ),
        ),
      ),
    );
  }
}

class UserFormData extends StatelessWidget {
  const UserFormData({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 20,
              left: 5,
            ),
            child: Text(
              'Dados pessoais',
              style: Theme.of(context).textTheme.labelLarge,
              textAlign: TextAlign.left,
            ),
          ),
          TextFormField(
            readOnly: true,
            initialValue: user.username,
            decoration: const InputDecoration(
              labelText: "Nome de usuário",
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            readOnly: true,
            initialValue: user.email,
            decoration: const InputDecoration(
              labelText: "Email",
            ),
          ),
        ],
      ),
    );
  }
}
