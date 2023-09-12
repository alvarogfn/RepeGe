import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/config/routes_name.dart';
import 'package:repege/modules/authentication/services/auth_service.dart';
import 'package:repege/modules/authentication/services/authentication_service.dart';
import 'package:repege/modules/home/components/icon_text_button.dart';
import 'package:repege/modules/home/components/navigation_list_item.dart';
import 'package:repege/modules/home/components/user_leading.dart';
import 'package:repege/screens/loading_page.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  Future<void> _logout(BuildContext context) async {
    return Future.delayed(
      const Duration(seconds: 0),
      () => showDialog(
        context: context,
        builder: (context) {
          AuthenticationService().logout();
          return const Dialog.fullscreen(child: LoadingPage());
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            title: const UserLeading(),
            actions: [
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: () => _logout(context),
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
