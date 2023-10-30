import 'package:repege/src/campaigns/domain/bloc/invitation_bloc.dart';
import 'package:repege/src/campaigns/domain/entities/invitation.dart';

abstract class InvitationRepository {
  const InvitationRepository();

  Stream<InvitationState> stream({required String guest});
  Future<InvitationState?> createInvite({required Invitation invite, required String username});
  Future<InvitationState?> verifyUsername(String username);
  Future<InvitationState?> acceptInvite(Invitation invite);
  Future<InvitationState?> denyInvite(Invitation invite);
}
