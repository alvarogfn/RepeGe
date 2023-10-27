import 'package:repege/src/campaigns/domain/bloc/invitation_bloc.dart';
import 'package:repege/src/campaigns/domain/entities/invitation.dart';

abstract class InvitationRepository {
  const InvitationRepository();

  Stream<InvitationState> stream({required String invitedId});
  Future<InvitationState?> inviteNewPlayer(String nickname, Invitation invite);
  Future<InvitationState?> acceptInvite(Invitation invite);
  Future<InvitationState?> denyInvite(Invitation invite);
}
