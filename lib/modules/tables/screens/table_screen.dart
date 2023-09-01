import 'package:flutter/material.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({super.key});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (destination) {},
        destinations: [
          NavigationDestination(icon: Icon(Icons.history), label: 'Atos')
        ],
      ),
    );
  }
}
