import 'package:flutter/material.dart';

class CampaignScreen extends StatefulWidget {
  const CampaignScreen({super.key});

  @override
  State<CampaignScreen> createState() => _CampaignScreenState();
}

class _CampaignScreenState extends State<CampaignScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (destination) {},
        destinations: const [
          NavigationDestination(icon: Icon(Icons.history), label: 'Atos'),
          NavigationDestination(icon: Icon(Icons.history), label: 'Jogadores'),
        ],
      ),
    );
  }
}
