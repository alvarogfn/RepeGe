import 'package:flutter/material.dart';
import 'package:repege/components/atoms/headline.dart';

class EnchancedCard extends StatelessWidget {
  const EnchancedCard({
    required this.title,
    required this.content,
    this.padding = const EdgeInsets.all(10),
    this.icon,
    super.key,
  });

  final Icon? icon;
  final String title;
  final Widget content;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (icon != null) icon!,
                  if (icon != null) const SizedBox(width: 10),
                  Headline(text: title, fontSize: 20),
                ],
              ),
            ),
            content,
          ],
        ),
      ),
    );
  }
}
