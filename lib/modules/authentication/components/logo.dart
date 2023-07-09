import 'package:flutter/material.dart';
import 'package:repege/modules/shared/components/headline.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Headline(
      'RepeGe',
      fontSize: 65,
      fontWeight: FontWeight.w900,
      margin: EdgeInsets.symmetric(vertical: 20),
    );
  }
}
