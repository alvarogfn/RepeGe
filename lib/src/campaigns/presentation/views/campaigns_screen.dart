import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/core/routes/routes_name.dart';
import 'package:repege/core/services/injection_container.dart';
import 'package:repege/src/authentication/domain/cubit/authentication_cubit.dart';
import 'package:repege/src/campaigns/domain/bloc/campaigns_bloc.dart';
import 'package:repege/src/miscellaneous/presentation/widgets/app_drawer.dart';

class CampaignsScreen extends StatelessWidget {
  const CampaignsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final campaign = sl<CampaignsBloc>();
        final state = context.read<AuthenticationCubit>().state;
        if (state is Authenticated) {
          campaign.add(CampaignsInitEvent(createdBy: state.user.id));
        }
        return campaign;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Campanhas'),
          actions: [
            IconButton(
              onPressed: () => context.pushNamed(Routes.campaignsCreate.name),
              icon: const Icon(Icons.add),
            )
          ],
        ),
        drawer: const AppDrawer(),
        body: BlocBuilder<CampaignsBloc, CampaignsState>(
          builder: (context, state) {
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
                      child: Card(
                        child: InkWell(
                          onTap: () => context.pushNamed(Routes.campaign.name, pathParameters: {
                            'id': campaign.id,
                          }),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ListTile(
                                trailing: PopupMenuButton(
                                  itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(
                                        child: const Text('Excluir'),
                                        onTap: () {
                                          final bloc = context.read<CampaignsBloc>();
                                          bloc.add(CampaignsDeleteEvent(campaign: campaign));
                                        },
                                      ),
                                    ];
                                  },
                                ),
                                title: Text(
                                  campaign.name,
                                  style: const TextStyle(fontWeight: FontWeight.w600),
                                ),
                                subtitle: RichText(
                                  text: TextSpan(
                                    text: 'Mestrado por ',
                                    style: Theme.of(context).textTheme.labelMedium,
                                    children: [
                                      TextSpan(
                                        text: 'user.username',
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                                child: Text(
                                  campaign.description,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
