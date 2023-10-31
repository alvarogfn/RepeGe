import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repege/core/icons/rpg_icons.dart';
import 'package:repege/core/services/injection_container.dart';
import 'package:repege/src/authentication/data/models/user_model.dart';
import 'package:repege/src/authentication/domain/cubit/authentication_cubit.dart';
import 'package:repege/src/campaigns/data/model/campaign_model.dart';
import 'package:repege/src/campaigns/domain/bloc/campaign_bloc.dart';
import 'package:repege/src/campaigns/presentation/widgets/campaign_act_page.dart';
import 'package:repege/src/campaigns/presentation/widgets/campaign_players_screen.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final bloc = sl<CampaignBloc>();
            bloc.add(CampaignInitEvent(widget.campaignId));
            return bloc;
          },
        ),
      ],
      child: BlocBuilder<CampaignBloc, CampaignState>(
        builder: (context, state) {
          final authState = context.read<AuthenticationCubit>().state as Authenticated;
          final user = authState.user as UserModel;

          switch (state) {
            case CampaignLoadedState():
              final campaign = state.campaign as CampaignModel;
              final isOwner = campaign.createdBy == user.id;

              return Scaffold(
                appBar: AppBar(
                  title: Text(state.campaign.name),
                  actions: isOwner
                      ? [
                          PopupMenuButton(
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                child: Text('Editar'),
                              )
                            ],
                          )
                        ]
                      : null,
                ),
                bottomNavigationBar: NavigationBar(
                  selectedIndex: currentPageIndex,
                  onDestinationSelected: (destination) => setState(() {
                    currentPageIndex = destination;
                  }),
                  destinations: const [
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
                  CampaignActPage(campaign: campaign, currentUser: user),
                  CampaignPlayersPage(campaign: campaign, currentUser: user),
                ][currentPageIndex],
              );
            case CampaignLoadingState():
              return const Scaffold(body: Center(child: CircularProgressIndicator()));
            case CampaignErrorState():
              return Scaffold(appBar: AppBar(), body: Text(state.message));
            default:
              return const SizedBox(child: Text('default'));
          }
        },
      ),
    );
  }
}
