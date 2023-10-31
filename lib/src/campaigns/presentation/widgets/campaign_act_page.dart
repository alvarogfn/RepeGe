import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/core/routes/routes_name.dart';
import 'package:repege/core/services/injection_container.dart';
import 'package:repege/src/authentication/data/models/user_model.dart';
import 'package:repege/src/authentication/domain/cubit/authentication_cubit.dart';
import 'package:repege/src/campaigns/data/model/act_model.dart';
import 'package:repege/src/campaigns/data/model/campaign_model.dart';
import 'package:repege/src/campaigns/domain/bloc/act_bloc.dart';
import 'package:repege/src/campaigns/presentation/widgets/act_list_item.dart';

class CampaignActPage extends StatelessWidget {
  const CampaignActPage({required this.campaign, required this.currentUser, super.key});

  final UserModel currentUser;
  final CampaignModel campaign;

  Future<void> _handleAddAct(BuildContext context) async {
    final newAct = await context.pushNamed<ActModel>(Routes.actsForm.name, pathParameters: {'id': campaign.id});
    if (newAct == null) return;

    if (context.mounted) {
      final authState = context.read<AuthenticationCubit>().state;
      if (authState is! Authenticated) return;
      context.read<ActBloc>().add(ActCreateOrUpdateActEvent(act: newAct.copyWith(campaignId: campaign.id)));
    }
  }

  bool get isOwner => currentUser.id == campaign.createdBy;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = sl<ActBloc>();
        bloc.add(ActInitEvent(campaignId: campaign.id));
        return bloc;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Acontecimentos'),
        ),
        floatingActionButton: isOwner
            ? Builder(builder: (context) {
                return FloatingActionButton(
                  onPressed: () => _handleAddAct(context),
                  child: const Icon(Icons.add),
                );
              })
            : null,
        body: BlocBuilder<ActBloc, ActState>(
          builder: (context, state) {
            switch (state) {
              case ActEmptyState():
                return const Center(child: Text('Nada aconteceu'));
              case ActErrorState():
                return Center(child: Text(state.message));
              case ActLoadingState():
                return const Center(child: CircularProgressIndicator());
              case ActLoadedState():
                return ListView.builder(
                  itemCount: state.acts.length,
                  itemBuilder: ((context, index) {
                    final act = state.acts[index];
                    return ActListItem(
                      act: act,
                      disableDismiss: currentUser.id != campaign.createdBy,
                    );
                  }),
                );
            }
          },
        ),
      ),
    );
  }
}
