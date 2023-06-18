import "package:flutter/material.dart";
import "package:repege/components/atoms/paragraph.dart";

class IconText extends StatelessWidget {
  const IconText(
    this.text, {
    required this.icon,
    this.spacing = 10,
    super.key,
    this.padding = const EdgeInsets.symmetric(vertical: 10),
  });

  final String text;
  final Icon icon;
  final double spacing;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [icon, SizedBox(width: spacing), Paragraph(text)],
      ),
    );
  }
}
