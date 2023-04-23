import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repege/components/shared/full_screen_scroll.dart';
import 'package:repege/components/shared/loading.dart';
import 'package:repege/database/users_db.dart';
import 'package:repege/models/user_model.dart';
import 'package:repege/pages/utils/loading_page.dart';
import 'package:repege/services/auth_service.dart';
import 'package:repege/utils/images.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<LoggedUserWithData> fetchUser() async {
    final AuthService auth = Provider.of(context, listen: false);
    return UsersDB().findByUID(auth.currentUser!.uid);
  }

  bool _editMode = false;

  @override
  Widget build(BuildContext context) {
    // final themeColors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: appBar(),
      body: FutureBuilder(
        future: fetchUser(),
        initialData: null,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          } else if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            final user = snapshot.data!;

            return FullScreenScroll(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 200,
                            width: 200,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.network(user.avatarURL),
                            ),
                          ),
                          const SizedBox(height: 10),
                          OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.image_search),
                            label: const Text('Atualizar'),
                          )
                        ],
                      ),
                    ),
                    Form(
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
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text('Perfil'),
    );
  }
}
