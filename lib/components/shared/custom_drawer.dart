import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/components/shared/loading.dart';
import 'package:repege/models/user.dart' as local;
import 'package:repege/route.dart';
import 'package:repege/services/auth_service.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Consumer<AuthService>(builder: (context, authService, child) {
        return Column(children: [
          AppBar(
            automaticallyImplyLeading: false,
            title: UserLeading(user: authService.user!),
            actions: [
              PopupMenuButton(
                itemBuilder: (ctx) => [
                  PopupMenuItem(
                    onTap: () {
                      context.goNamed(RoutesName.login.name);
                      authService.logout();
                    },
                    child:
                        const IconTextButton(icon: Icons.logout, text: "Sair"),
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
                  text: "Fichas",
                  route: RoutesName.sheets,
                ),
                NavigationListItem(
                  icon: Icons.groups,
                  text: "Mesas",
                  route: RoutesName.tables,
                ),
              ],
            ),
          )
        ]);
      }),
    );
  }
}

class NavigationListItem extends StatelessWidget {
  const NavigationListItem({
    required this.icon,
    required this.text,
    required this.route,
    super.key,
  });

  final RoutesName route;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      style: ListTileStyle.drawer,
      leading: Icon(icon, color: Theme.of(context).primaryColor),
      minLeadingWidth: 30,
      visualDensity: VisualDensity.compact,
      title: Text(text),
      onTap: () => context.goNamed(route.name),
    );
  }
}

class UserLeading extends StatelessWidget {
  const UserLeading({
    super.key,
    required this.user,
  });

  final local.User user;

  Future<void> navigateToProfile(BuildContext context) async {
    context.pushNamed(RoutesName.profile.name);
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Loading(color: Colors.white);
    }
    return Row(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: () => navigateToProfile(context),
          child: CircleAvatar(backgroundImage: avatar(user.avatarURL)),
        ),
        const SizedBox(width: 10),
        Text(
          user.username,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  ImageProvider avatar(String? avatarURL) {
    if (avatarURL != null) {
      return NetworkImage(avatarURL);
    }

    return const AssetImage("assets/images/default_profile_picture.png");
  }
}

class IconTextButton extends StatelessWidget {
  const IconTextButton({required this.icon, required this.text, super.key});

  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(color: color, fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
