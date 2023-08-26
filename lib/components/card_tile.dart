import 'package:flutter/material.dart';

class CardTile extends StatelessWidget {
  const CardTile({
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.content,
    this.actions = const [],
    this.padding = const EdgeInsets.fromLTRB(15, 0, 15, 15),
    super.key,
  });

  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final Widget? leading;
  final Widget? content;
  final List<Widget> actions;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (subtitle != null ||
                title != null ||
                trailing != null ||
                leading != null)
              ListTile(
                titleTextStyle: Theme.of(context).textTheme.titleSmall,
                subtitle: subtitle,
                title: title,
                leading: leading,
                trailing: trailing,
                minLeadingWidth: 20,
              ),
            if (content != null) content!,
            Row(
              children: actions,
            ),
          ],
        ),
      ),
    );
  }
}
