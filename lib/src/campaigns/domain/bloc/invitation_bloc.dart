import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repege/src/campaigns/data/model/invitation_model.dart';
import 'package:repege/src/campaigns/domain/entities/invitation.dart';
import 'package:repege/src/campaigns/domain/repositories/invitation_repository.dart';

part 'invitation_event.dart';
part 'invitation_state.dart';

class InvitationBloc extends Bloc<InvitationEvent, InvitationState> {
  final InvitationRepository _repository;

  InvitationBloc(this._repository) : super(const InvitationLoadingEvent()) {
    on<InvitationInitEvent>((event, emit) async {
      return emit.onEach(_repository.stream(guest: event.userId), onData: (state) => emit(state));
    });

    on<InvitationAcceptInviteEvent>((event, emit) async {
      final result = await _repository.acceptInvite(event.invitation);
      if (result != null) emit(result);
    });

    on<InvitationNewInviteEvent>((event, emit) async {
      emit(const InvitationLoadingEvent('creating-invite'));
      final usernameState = await _repository.verifyUsername(event.username);

      if (usernameState != null) return emit(usernameState);

      final invitation = InvitationModel.empty();

      final inviteState = await _repository.createInvite(
        invite: invitation.copyWith(
          accepted: false,
          pending: true,
          campaignId: event.campaignId,
          inviter: event.inviter,
        ),
        username: event.username,
      );

      if (inviteState != null) emit(inviteState);
    });

    on<InvitationDenyInviteEvent>((event, emit) async {
      final result = await _repository.denyInvite(event.invitation.copyWith(
        pending: false,
        accepted: false,
        sheetId: null,
      ));
      if (result != null) emit(result);
    });
  }
}
