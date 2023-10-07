import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CampaignPl
ayersScreen extends StatefulWidget {
  const CampaignPlayersScreen(
    this.playersId, {
    super.key,
  });

  final List<String> playersId;

  @override
  State<CampaignPlayersScreen> createState() => _CampaignPlayersScreenState();
}

class _CampaignPlayersScreenState extends State<CampaignPlayersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jogadores'),
      ),
      body: ListView(
        children: widget.playersId.map((e) {
          return FutureBuilder(
            create: () {},
            initialData: initialData,
          );
        }).toList(),
      ),
    );
  }
}
