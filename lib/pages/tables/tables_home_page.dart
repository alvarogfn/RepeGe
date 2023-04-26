import 'package:flutter/material.dart';
import 'package:repege/components/shared/custom_drawer.dart';
import 'package:repege/components/shared/full_screen_scroll.dart';

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
