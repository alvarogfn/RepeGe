import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  const IconText(this.text, {required this.icon, this.spacing = 10, super.key});

  final String text;
  final Icon icon;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        icon,
        SizedBox(width: spacing),
        Text(text, style: textTheme.labelLarge)
      ],
    );
  }
}
