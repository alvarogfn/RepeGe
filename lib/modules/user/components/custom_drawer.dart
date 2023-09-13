import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/config/routes_name.dart';
import 'package:repege/helpers/is_snapshot_loading.dart';
import 'package:repege/modules/authentication/services/auth_service.dart';
import 'package:repege/modules/user/components/icon_text_button.dart';
import 'package:repege/modules/user/components/navigation_list_item.dart';
import 'package:repege/modules/user/services/user_service.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            title: StreamBuilder(
              stream: UserService().stream(),
              builder: (context, snapshot) {
                if (isSnapshotLoading(snapshot)) {
                  return const Text('Carregando..');
                }
                if (snapshot.hasError) {
                  print(snapshot.error);
                }
                if (!snapshot.hasData) return const SizedBox();

                final user = snapshot.data!;

                return Row(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () => context.pushNamed(RoutesName.profile.name),
                      child: CircleAvatar(backgroundImage: user.avatar),
                    ),
                    const SizedBox(width: 15),
                    Text(
                      user.username,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                );
              },
            ),
            actions: [
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: () => authService.logout(),
                    child: const IconTextButton(
                      icon: Icons.logout,
                      text: 'Sair',
                    ),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              children: const [
                NavigationListItem(
                  icon: Icons.article,
                  text: 'Fichas',
                  route: RoutesName.sheets,
                ),
                NavigationListItem(
                  icon: Icons.groups,
                  text: 'Mesas',
                  route: RoutesName.tables,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
