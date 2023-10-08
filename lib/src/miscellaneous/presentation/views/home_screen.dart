import 'package:flutter/material.dart';
import 'package:repege/src/miscellaneous/presentation/widgets/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Início')),
      drawer: const AppDrawer(),
      body: const Scaffold(
        body: Center(
          child: Text('O que vamos jogar hoje?'),
        ),
      ),
    );
  }
}
