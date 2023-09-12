import 'package:flutter/material.dart';
import 'package:repege/components/custom_drawer.dart';
import 'package:repege/components/stream_auth_builder.dart';
import 'package:repege/modules/authentication/services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamAuthBuilder(
      child: Scaffold(
        appBar: AppBar(title: const Text('Início')),
        drawer: const CustomDrawer(),
      ),
    );
  }
}
