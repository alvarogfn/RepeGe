import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  const Label({required this.title, required this.content, super.key});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: textTheme.titleSmall),
        const SizedBox(height: 5),
        Text(content, style: textTheme.bodyMedium),
      ],
    );
  }
}
