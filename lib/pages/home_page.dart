import 'package:flutter/material.dart';
import 'package:tcc/services/auth_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("RepeGe")),
      drawer: const Drawer(
        child: TextButton(onPressed: AuthService.logout, child: Text('oi')),
      ),
    );
  }
}
