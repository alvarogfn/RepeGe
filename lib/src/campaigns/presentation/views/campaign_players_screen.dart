import 'package:flutter/material.dart';

class CampaignPlayersScreen extends StatefulWidget {
  const CampaignPlayersScreen({super.key});

  @override
  State<CampaignPlayersScreen> createState() => _CampaignPlayersScreenState();
}

class _CampaignPlayersScreenState extends State<CampaignPlayersScreen> {
  @override
  Widget build(BuildContext context) {
    return const Text('');
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('Jogadores'),
    //   ),
    //   body: ListView(
    //     children: widget.playersId.map((e) {
    //       return FutureBuilder(
    //         create: () {},
    //         initialData: initialData,
    //       );
    //     }).toList(),
    //   ),
    // );
  }
}
