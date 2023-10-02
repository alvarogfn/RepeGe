import 'package:flutter/material.dart';

class CampaignScreen extends StatefulWidget {
  const CampaignScreen({super.key});

  @override
  State<CampaignScreen> createState() => _CampaignScreenState();
}

class _CampaignScreenState extends State<CampaignScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (destination) => setState(() {
          currentPageIndex = destination;
        }),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.history), label: 'Atos'),
          NavigationDestination(icon: Icon(Icons.history), label: 'Jogadores'),
        ],
      ),
      body: [
        ListView(
          children: [],
        ),
        ListView(
          children: [],
        ),
        ListView(
          children: [],
        )
      ][currentPageIndex],
    );
  }
}
