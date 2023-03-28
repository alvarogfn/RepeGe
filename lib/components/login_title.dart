import 'package:flutter/material.dart';

class LoginTitle extends StatelessWidget {
  final String title;

  const LoginTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
