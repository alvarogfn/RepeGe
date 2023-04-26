import 'package:flutter/material.dart';

class TipCard extends StatelessWidget {
  const TipCard(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final Color grey = Theme.of(context).colorScheme.primary.withAlpha(200);

    TextStyle? textStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
          height: 1.5,
          color: grey,
        );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.tips_and_updates, color: grey),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            textAlign: TextAlign.justify,
            style: textStyle,
          ),
        ),
      ],
    );
  }
}
