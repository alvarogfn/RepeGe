import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repege/src/campaigns/data/model/invitation_model.dart';
import 'package:repege/src/campaigns/domain/entities/invitation.dart';
import 'package:repege/src/campaigns/domain/repositories/invitation_repository.dart';

part 'invitation_event.dart';
part 'invitation_state.dart';

class InvitationBloc extends Bloc<InvitationEvent, InvitationState> {
  final InvitationRepository _repository;

  InvitationBloc(this._repository) : super(const InvitationLoading()) {
    on<InvitationInitEvent>((event, emit) async {
      return emit.onEach(_repository.stream(invitedId: event.userId), onData: (state) => emit(state));
    });

    on<InvitationAcceptInviteEvent>((event, emit) async {
      final result = await _repository.acceptInvite(event.invitation);
      if (result != null) emit(result);
    });

    on<InvitationNewInviteEvent>((event, emit) async {
      final result = await _repository.inviteNewPlayer(event.username, event.invitation);
      if (result != null) emit(result);
    });

    on<InvitationDenyInviteEvent>((event, emit) async {
      final result = await _repository.denyInvite(event.invitation);
      if (result != null) emit(result);
    });
  }
}
