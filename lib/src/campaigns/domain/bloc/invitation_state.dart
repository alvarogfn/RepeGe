part of 'invitation_bloc.dart';

sealed class InvitationState extends Equatable {
  const InvitationState();

  @override
  List<Object> get props => [];
}

final class InvitationEmptyState extends InvitationState {
  const InvitationEmptyState();
}

final class InvitationLoading extends InvitationState {
  const InvitationLoading();
}

final class InvitationLoadedState extends InvitationState {
  final List<InvitationModel> invitations;

  const InvitationLoadedState(this.invitations);

  @override
  List<Object> get props => [for (var invite in invitations) ...invite.props];
}

final class InvitationErrorState extends InvitationState {
  final String message;

  const InvitationErrorState(this.message);

  @override
  List<Object> get props => [message];
}
