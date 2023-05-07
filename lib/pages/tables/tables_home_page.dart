import 'package:flutter/material.dart';
import 'package:repege/components/organism/custom_drawer.dart';

class TablesHomePage extends StatelessWidget {
  const TablesHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.save)),
        ],
      ),
      drawer: const CustomDrawer(),
    );
  }
}
