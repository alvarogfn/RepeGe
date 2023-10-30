import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/core/routes/routes_name.dart';
import 'package:repege/core/services/injection_container.dart';
import 'package:repege/core/widgets/paragraph.dart';
import 'package:repege/src/authentication/domain/cubit/authentication_cubit.dart';
import 'package:repege/src/campaigns/data/model/invitation_model.dart';
import 'package:repege/src/campaigns/domain/bloc/campaign_bloc.dart';
import 'package:repege/src/campaigns/domain/bloc/invitation_bloc.dart';
import 'package:repege/src/sheets/data/models/sheet_model.dart';
import 'package:repege/src/sheets/domain/bloc/sheet_bloc.dart';
import 'package:intl/intl.dart';

class InvitationListItem extends StatelessWidget {
  const InvitationListItem(
    this.invitation, {
    super.key,
  });

  final InvitationModel invitation;

  Future<void> _handleAccept(BuildContext context) async {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! Authenticated) return;

    final sheet = await context.pushNamed<SheetModel>(Routes.sheetSelect.name, pathParameters: {
      'createdBy': authState.user.id,
    });

    if (sheet != null && context.mounted) {
      final inviteEvent = InvitationAcceptInviteEvent(
        invitation: invitation.copyWith(sheetId: sheet.id),
      );

      context.read<InvitationBloc>().add(inviteEvent);
    }
  }

  Future<void> _handleDeny(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Negar o convite?',
            style: TextStyle(color: Colors.black),
          ),
          content: const Text('Você poderá ser convidado novamente se negar este convite.'),
          actions: [
            OutlinedButton(onPressed: () => context.pop(true), child: const Text('Confirmar')),
          ],
        );
      },
    );

    if (confirm == true && context.mounted) {
      context.read<InvitationBloc>().add(InvitationDenyInviteEvent(invitation));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final bloc = sl<SheetBloc>();
            final authState = context.read<AuthenticationCubit>().state;

            if (authState is Authenticated && invitation.sheetId != null) {
              bloc.add(SheetInitEvent(invitation.sheetId!));
            }

            return bloc;
          },
        ),
        BlocProvider(
          create: (context) {
            final bloc = sl<CampaignBloc>();
            final authState = context.read<AuthenticationCubit>().state;

            if (authState is Authenticated) {
              bloc.add(CampaignInitEvent(invitation.campaignId));
            }

            return bloc;
          },
        ),
      ],
      child: Card(
        child: BlocBuilder<CampaignBloc, CampaignState>(
          builder: (context, state) {
            switch (state) {
              case CampaignLoadingState():
                return const Center(child: CircularProgressIndicator());
              case CampaignLoadedState():
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        state.campaign.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Paragraph('Campanha narrada por **${state.campaign.creatorUsername}.**'),
                      trailing: Text(DateFormat.yMd().add_Hm().format(state.campaign.createdAt)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: invitation.pending
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () => _handleDeny(context),
                                  child: const Text('Negar'),
                                ),
                                const SizedBox(width: 25),
                                ElevatedButton(
                                  onPressed: () => _handleAccept(context),
                                  child: const Text('Aceitar'),
                                )
                              ],
                            )
                          : BlocBuilder<SheetBloc, SheetState>(
                              builder: (context, state) {
                                if (state is SheetLoaded) {
                                  return Text('Você aceitou com ${state.sheet.characterName}');
                                }
                                return SizedBox();
                              },
                            ),
                    )
                  ],
                );
              case CampaignErrorState():
                return const Text('Não foi possível carregar esse convite');
              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
