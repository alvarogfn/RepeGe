import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "RepeGe",
      style: TextStyle(
        fontSize: 60,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}
