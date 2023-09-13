import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/components/loading.dart';
import 'package:repege/config/routes_name.dart';
import 'package:repege/modules/auth/services/auth_service.dart';
import 'package:repege/modules/user/components/icon_text_button.dart';
import 'package:repege/modules/user/components/navigation_list_item.dart';

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
            title: Consumer<AuthService>(builder: (context, authService, child) {
              final user = authService.user;

              if (user == null) return const Loading();

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
            }),
            actions: [
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: () => context.read<AuthService>().signOut(),
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
