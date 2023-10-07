import 'package:flutter/material.dart';

class NavigationListItem extends StatelessWidget {
  const NavigationListItem({
    required this.icon,
    required this.text,
    required this.onTap,
    super.key,
  });

  final String text;
  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      style: ListTileStyle.drawer,
      leading: Icon(icon, color: Theme.of(context).primaryColor),
      minLeadingWidth: 30,
      visualDensity: VisualDensity.compact,
      title: Text(text),
      onTap: onTap,
    );
  }
}
