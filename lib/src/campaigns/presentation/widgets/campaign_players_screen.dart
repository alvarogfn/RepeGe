import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/core/routes/routes_name.dart';
import 'package:repege/core/utils/validations/alphanum_validation.dart';
import 'package:repege/core/utils/validations/required_validation.dart';
import 'package:repege/core/utils/validations/validations.dart';
import 'package:repege/core/widgets/show_keyboard_bottom_sheet.dart';
import 'package:repege/src/authentication/domain/cubit/authentication_cubit.dart';
import 'package:repege/src/campaigns/data/model/campaign_model.dart';
import 'package:repege/src/campaigns/data/model/invitation_model.dart';
import 'package:repege/src/campaigns/domain/bloc/invitation_bloc.dart';

class CampaignPlayersPage extends StatelessWidget {
  const CampaignPlayersPage(this.campaign, {super.key});

  final CampaignModel campaign;

  Future<void> _inviteNewPlayer(BuildContext context) async {
    showKeyboardBottomSheet(isDismissible: false, context, builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Convidar novo participante'),
          actions: [
            IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.close)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                initialValue: '',
                decoration: const InputDecoration(
                  labelText: 'Nome de usuário',
                ),
                onFieldSubmitted: (value) => context.pop(value),
                validator: (value) => Validator.validateWith(value, [
                  RequiredValidation(),
                  AlphanumValidation(),
                ]),
              ),
              const Spacer(),
            ],
          ),
        ),
      );
    });
    final username = await context.pushNamed<String?>(Routes.campaignInvite.name, pathParameters: {
      'id': campaign.id,
    });

    if (username == null) return;

    if (context.mounted) {
      final authState = context.read<AuthenticationCubit>().state;

      if (authState is Authenticated) {
        final bloc = context.read<InvitationBloc>();

        bloc.add(InvitationNewInviteEvent(
          invitation: InvitationModel.empty().copyWith(
            accepted: false,
            pending: true,
            campaignId: campaign.id,
          ),
          username: username,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Participantes'),
        actions: [
          IconButton(
            onPressed: () => _inviteNewPlayer(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: const Center(child: Text('Nenhum participante')),
    );
  }
}
