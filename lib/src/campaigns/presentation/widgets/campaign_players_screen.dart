import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/core/routes/routes_name.dart';
import 'package:repege/core/services/injection_container.dart';
import 'package:repege/core/utils/validations/alphanum_validation.dart';
import 'package:repege/core/utils/validations/required_validation.dart';
import 'package:repege/core/utils/validations/validations.dart';
import 'package:repege/core/widgets/show_keyboard_bottom_sheet.dart';
import 'package:repege/src/authentication/data/models/user_model.dart';
import 'package:repege/src/campaigns/data/model/campaign_model.dart';
import 'package:repege/src/campaigns/domain/bloc/invitation_bloc.dart';
import 'package:repege/src/sheets/domain/bloc/sheet_list_bloc.dart';
import 'package:repege/src/sheets/domain/entities/sheet.dart';
import 'package:repege/src/sheets/presentation/widgets/sheet_list_item.dart';

class CampaignPlayersPage extends StatelessWidget {
  const CampaignPlayersPage({required this.campaign, required this.currentUser, super.key});

  final UserModel currentUser;
  final CampaignModel campaign;

  Future<void> _inviteNewPlayer(BuildContext context) async {
    final username = await showKeyboardBottomSheet<String>(context, builder: (context) {
      TextTheme textTheme = Theme.of(context).textTheme;

      return Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Convidar um novo participante', style: textTheme.titleLarge!.copyWith(color: Colors.black)),
            const SizedBox(height: 25),
            TextFormField(
              initialValue: '',
              decoration: const InputDecoration(
                labelText: 'Nome de usuário',
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              onFieldSubmitted: (value) async {
                final isConfirmed = await showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        "Convidar '$value' para a campanha?",
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => context.pop(false),
                          child: const Text('Não'),
                        ),
                        ElevatedButton(
                          onPressed: () => context.pop(true),
                          child: const Text('Sim'),
                        ),
                      ],
                    );
                  },
                );

                if (isConfirmed != null && isConfirmed && context.mounted) {
                  context.pop(value);
                }
              },
              validator: (value) => Validator.validateWith(value, [
                RequiredValidation(),
                AlphanumValidation(),
              ]),
            ),
          ],
        ),
      );
    });

    if (username == null) return;

    if (context.mounted) {
      final bloc = context.read<InvitationBloc>();
      bloc.add(InvitationNewInviteEvent(
        campaignId: campaign.id,
        username: username,
        inviter: currentUser.id,
      ));
    }
  }

  bool get isOwner => currentUser.id == campaign.createdBy;

  void Function()? _handleSheetOpen(BuildContext context, Sheet sheet) {
    if (isOwner) {
      return () => context.pushNamed(Routes.sheetView.name, pathParameters: {'id': sheet.id});
    }

    if (currentUser.id == sheet.createdBy) {
      return () => context.pushNamed(Routes.sheet.name, pathParameters: {'id': sheet.id});
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<InvitationBloc>(),
      child: BlocListener<InvitationBloc, InvitationState>(
        listener: (context, state) {
          switch (state) {
            case InvitationInvitedState():
              showDialog(
                context: context,
                builder: (context) {
                  return const AlertDialog(title: Text('Convite enviado.'));
                },
              );
            case InvitationErrorState():
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      state.message,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  );
                },
              );
            default:
          }
        },
        child: BlocProvider(
          create: (context) {
            final bloc = sl<SheetListBloc>();

            bloc.add(SheetListInitEvent(whereIn: campaign.participants.values.toList()));

            return bloc;
          },
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text('Participantes'),
              actions: [
                if (isOwner)
                  Builder(builder: (context) {
                    return IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () => _inviteNewPlayer(context),
                    );
                  }),
              ],
            ),
            body: BlocBuilder<SheetListBloc, SheetListState>(
              builder: (context, state) {
                switch (state) {
                  case SheetListLoaded():
                    return ListView.builder(
                      itemCount: state.sheets.length,
                      itemBuilder: (context, index) {
                        final sheet = state.sheets[index];

                        return SheetListItem(
                          sheet: sheet,
                          onTap: _handleSheetOpen(context, sheet),
                        );
                      },
                    );
                  case SheetListEmpty():
                    return const Center(
                      child: Text('Nenhum participante.'),
                    );
                  case SheetListLoadError():
                    return const Center(
                      child: Text('Não foi possível carregar os participantes.'),
                    );
                  case SheetListLoading():
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
