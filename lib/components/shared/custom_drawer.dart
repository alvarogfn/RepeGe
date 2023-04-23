import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/components/shared/loading.dart';
import 'package:repege/database/users_db.dart';
import 'package:repege/models/user_model.dart';
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
    final authService = Provider.of<AuthService>(context, listen: false);

    return Drawer(
      child: Column(children: [
        AppBar(
          automaticallyImplyLeading: false,
          title: Consumer<AuthService>(builder: (context, value, _) {
            if (value.currentUser != null) {
              return UserLeading(user: value.currentUser!);
            }
            return const SizedBox();
          }),
          actions: [
            PopupMenuButton(
              itemBuilder: (ctx) => [
                PopupMenuItem(
                  onTap: () {
                    context.goNamed(RoutesName.login.name);
                    authService.logout();
                  },
                  child: const IconTextButton(icon: Icons.logout, text: "Sair"),
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
      ]),
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

  final LoggedUser user;

  Future<void> navigateToProfile(BuildContext context) async {
    context.pushNamed(RoutesName.profile.name);
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      InkWell(
        borderRadius: BorderRadius.circular(20),
        child: FutureBuilder<LoggedUserWithData>(
            future: UsersDB().findByUID(user.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loading();
              }
              return CircleAvatar(
                backgroundImage: NetworkImage(snapshot.data!.avatarURL),
              );
            }),
        onTap: () => navigateToProfile(context),
      ),
      const SizedBox(width: 10),
      Text(
        user.email,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      )
    ]);
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
