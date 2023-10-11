import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repege/icons/rpg_icons.dart';
import 'package:repege/modules/campaign/model/campaign.dart';
import 'package:repege/modules/campaign/service/campaign_service.dart';
import 'package:repege/screens/loading_page.dart';

class CampaignScreen extends StatefulWidget {
  const CampaignScreen(this.campaignId, {super.key});

  final String campaignId;

  @override
  State<CampaignScreen> createState() => _CampaignScreenState();
}

class _CampaignScreenState extends State<CampaignScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CampaignService(widget.campaignId),
      builder: (context, child) {
        return StreamProvider(
            create: (_) => context.read<CampaignService>().stream(),
            initialData: null,
            builder: (context, child) {
              final campaign = context.watch<Campaign?>();

              if (campaign == null) return const LoadingPage();

              return Scaffold(
                appBar: AppBar(
                  title: Text(campaign.name),
                ),
                bottomNavigationBar: NavigationBar(
                  selectedIndex: currentPageIndex,
                  onDestinationSelected: (destination) => setState(() {
                    currentPageIndex = destination;
                  }),
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.info),
                      label: 'Detalhes',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.history_edu),
                      label: 'Atos',
                    ),
                    NavigationDestination(
                      icon: Icon(Rpg.player),
                      label: 'Jogadores',
                    ),
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
                  ),
                ][currentPageIndex],
              );
            });
      },
    );
  }
}