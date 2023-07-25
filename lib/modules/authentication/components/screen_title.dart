import 'package:flutter/material.dart';
import 'package:repege/components/headline.dart';

class ScreenTitle extends StatelessWidget {
  const ScreenTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Headline(
      title,
      fontSize: 25,
      fontWeight: FontWeight.w900,
      margin: const EdgeInsets.symmetric(vertical: 20),
    );
  }
}
