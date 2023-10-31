import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/core/routes/routes_name.dart';
import 'package:repege/core/services/injection_container.dart';
import 'package:repege/src/authentication/domain/cubit/authentication_cubit.dart';
import 'package:repege/src/campaigns/data/model/campaign_model.dart';
import 'package:repege/src/campaigns/domain/bloc/campaigns_bloc.dart';
import 'package:repege/src/campaigns/presentation/widgets/campaign_list_item.dart';
import 'package:repege/src/miscellaneous/presentation/widgets/app_drawer.dart';

class CampaignsScreen extends StatelessWidget {
  const CampaignsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = sl<CampaignsBloc>();

        final authState = context.read<AuthenticationCubit>().state;
        if (authState is! Authenticated) {
          bloc.add(const CampaignsErrorEvent(message: 'Não foi possível buscar, você não está autenticado.'));
          return bloc;
        }

        bloc.add(CampaignsInitEvent(userId: authState.user.id));
        return bloc;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Campanhas'),
          actions: [
            IconButton(
              onPressed: () => context.pushNamed(Routes.invites.name),
              icon: const Icon(Icons.mail),
            ),
            Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () async {
                    final campaign = await context.pushNamed<CampaignModel>(Routes.campaignsCreate.name);
                    if (campaign == null) return;
                    if (context.mounted) {
                      final userState = context.read<AuthenticationCubit>().state;
                      if (userState is! Authenticated) return;

                      final campaignsBloc = context.read<CampaignsBloc>();

                      campaignsBloc.add(CampaignsCreateEvent(campaign: campaign, user: userState.user));
                    }
                  },
                  icon: const Icon(Icons.add),
                );
              },
            ),
          ],
        ),
        drawer: const AppDrawer(),
        body: BlocBuilder<CampaignsBloc, CampaignsState>(
          builder: (context, state) {
            final user = (context.read<AuthenticationCubit>().state as Authenticated).user;

            switch (state) {
              case CampaignsEmptyState():
                return const Center(child: Text('Nenhuma campanha.'));
              case CampaignsLoadingState():
                return const Center(child: CircularProgressIndicator());
              case CampaignsErrorState():
                return Center(
                  child: Text(state.message),
                );
              case CampaignsLoadedState():
                return ListView.builder(
                  itemCount: state.campaigns.length,
                  padding: const EdgeInsets.all(5),
                  itemBuilder: (context, index) {
                    final campaign = state.campaigns[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: CampaignListItem(campaign: campaign, currentUser: user),
                    );
                  },
                );
            }
          },
        ),
      ),
    );
  }
}
