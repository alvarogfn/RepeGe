import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repege/core/icons/rpg_icons.dart';
import 'package:repege/core/services/injection_container.dart';
import 'package:repege/src/campaigns/data/model/campaign_model.dart';
import 'package:repege/src/campaigns/domain/bloc/campaign_bloc.dart';
import 'package:repege/src/campaigns/presentation/widgets/campaign_act_page.dart';
import 'package:repege/src/campaigns/presentation/widgets/campaign_info_page.dart';

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
    return BlocProvider(
      create: (context) {
        final bloc = sl<CampaignBloc>();
        bloc.add(CampaignInitEvent(widget.campaignId));
        return bloc;
      },
      child: BlocBuilder<CampaignBloc, CampaignState>(
        builder: (context, state) {
          switch (state) {
            case CampaignLoadedState():
              final campaign = state.campaign as CampaignModel;

              return Scaffold(
                appBar: AppBar(
                  title: Text(state.campaign.name),
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
                  CampaignInfoPage(campaign),
                  CampaignActPage(campaign),
                  ListView(
                    children: [],
                  ),
                ][currentPageIndex],
              );
            case CampaignLoadingState():
              return const Scaffold(body: Center(child: CircularProgressIndicator()));
            case CampaignErrorState():
              return Scaffold(appBar: AppBar(), body: Text(state.message));
            default:
              return SizedBox(
                child: Text('default'),
              );
          }
        },
      ),
    );
  }
}
