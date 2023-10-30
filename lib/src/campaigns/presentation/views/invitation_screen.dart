import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repege/core/services/injection_container.dart';
import 'package:repege/src/authentication/domain/cubit/authentication_cubit.dart';
import 'package:repege/src/campaigns/domain/bloc/invitation_bloc.dart';
import 'package:repege/src/campaigns/presentation/widgets/invitation_list_item.dart';

class InvitationScreen extends StatelessWidget {
  const InvitationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = sl<InvitationBloc>();
        final authState = context.read<AuthenticationCubit>().state;

        if (authState is Authenticated) {
          bloc.add(InvitationInitEvent(authState.user.id));
        }

        return bloc;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Seus convites'),
        ),
        body: BlocBuilder<InvitationBloc, InvitationState>(
          builder: (context, state) {
            switch (state) {
              case InvitationEmptyState():
                return const Center(child: Text('Nenhum convite pendente.'));
              case InvitationLoadedState():
                return ListView.builder(
                  itemBuilder: (context, index) => InvitationListItem(state.invitations[index]),
                  itemCount: state.invitations.length,
                  padding: const EdgeInsets.all(5),
                );
              case InvitationLoadingEvent():
                return const Center(child: CircularProgressIndicator());
              case InvitationErrorState():
                return Center(child: Text(state.message));
              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
