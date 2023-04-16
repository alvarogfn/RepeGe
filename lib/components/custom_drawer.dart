import 'package:flutter/material.dart';
import 'package:tcc/models/user_model.dart';
import 'package:tcc/pages/sheets/sheet_home_page.dart';
import 'package:tcc/pages/user_config_page.dart';
import 'package:tcc/services/auth_service.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final LoggedUser user = AuthService.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        AppBar(
          automaticallyImplyLeading: false,
          title: UserLeading(user: user),
          actions: [
            PopupMenuButton(
              itemBuilder: (ctx) => [
                const PopupMenuItem(
                  onTap: AuthService.logout,
                  child: IconTextButton(icon: Icons.logout, text: "Sair"),
                ),
              ],
            ),
          ],
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            children: [
              NavigationListItem(
                icon: Icons.article,
                text: "Fichas",
                page: SheetHomePage(),
              ),
              NavigationListItem(
                icon: Icons.groups,
                text: "Campanhas",
                page: SheetHomePage(),
              ),
            ],
          ),
        )
        // ListView(
        //   children: [Text('hehe')],
        // )
      ]),
    );
  }
}

class NavigationListItem extends StatelessWidget {
  const NavigationListItem({
    required this.icon,
    required this.text,
    required this.page,
    super.key,
  });

  final Widget page;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      style: ListTileStyle.drawer,
      leading: Icon(
        icon,
        color: Theme.of(context).primaryColor,
      ),
      minLeadingWidth: 30,
      visualDensity: VisualDensity.compact,
      title: Text(text),
      onTap: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (ctx) => page,
        ));
      },
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
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const UserConfigPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      InkWell(
        borderRadius: BorderRadius.circular(20),
        child: const CircleAvatar(
          backgroundImage: NetworkImage(
            'https://www.pngkit.com/png/detail/112-1120367_d-d-elf-png-male-half-elf-bard.png',
          ),
        ),
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
