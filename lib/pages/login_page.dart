import 'package:flutter/material.dart';
import '../components/login_title.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Card(
            child: LoginTitle(
              title: "RepeGe",
            ),
          ),
        ),
      ),
    );
  }
}
