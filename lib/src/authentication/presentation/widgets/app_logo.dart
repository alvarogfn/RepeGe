import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({required this.subtitle, super.key});

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'RepeGe',
          style: textTheme.displayLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Text(
          subtitle,
          style: textTheme.displayMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
