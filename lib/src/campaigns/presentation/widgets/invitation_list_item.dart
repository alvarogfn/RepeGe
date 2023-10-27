import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/core/routes/routes_name.dart';
import 'package:repege/src/authentication/domain/cubit/authentication_cubit.dart';
import 'package:repege/src/campaigns/data/model/invitation_model.dart';
import 'package:repege/src/campaigns/domain/bloc/invitation_bloc.dart';
import 'package:repege/src/sheets/data/models/sheet_model.dart';

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
      'id': authState.user.id,
    });

    if (sheet == null && context.mounted) {
      context.read<InvitationBloc>().add(InvitationAcceptInviteEvent(invitation: invitation, sheetId: sheet!.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: const Text(
              ' invitation.campaignName',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text('Convite feito por }'),
            trailing: Text(invitation.createdAt.toIso8601String()),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Negar'),
                ),
                const SizedBox(width: 25),
                ElevatedButton(
                  onPressed: () => _handleAccept(context),
                  child: const Text('Aceitar'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
