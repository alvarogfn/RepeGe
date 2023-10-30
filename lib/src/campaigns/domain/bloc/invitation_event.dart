// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'invitation_bloc.dart';

sealed class InvitationEvent extends Equatable {
  const InvitationEvent();

  @override
  List<Object> get props => [];
}

class InvitationInitEvent extends InvitationEvent {
  final String userId;
  const InvitationInitEvent(this.userId);
}

class InvitationNewInviteEvent extends InvitationEvent {
  final String username;
  final String inviter;
  final String campaignId;

  const InvitationNewInviteEvent({
    required this.username,
    required this.inviter,
    required this.campaignId,
  });
}

class InvitationAcceptInviteEvent extends InvitationEvent {
  final Invitation invitation;
  const InvitationAcceptInviteEvent({required this.invitation});
}

class InvitationDenyInviteEvent extends InvitationEvent {
  final Invitation invitation;
  const InvitationDenyInviteEvent(this.invitation);
}
