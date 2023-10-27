import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:repege/src/campaigns/domain/bloc/invitation_bloc.dart';
import 'package:repege/src/campaigns/domain/entities/invitation.dart';
import 'package:repege/src/campaigns/domain/repositories/invitation_repository.dart';

class InvitationRepositoryImpl extends InvitationRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  const InvitationRepositoryImpl(this._auth, this._firestore);

  @override
  Future<InvitationState?> acceptInvite(Invitation invite) {
    // TODO: implement acceptInvite
    throw UnimplementedError();
  }

  @override
  Future<InvitationState?> denyInvite(Invitation invite) {
    // TODO: implement denyInvite
    throw UnimplementedError();
  }

  @override
  Future<InvitationState?> inviteNewPlayer(String nickname, Invitation invite) {
    // TODO: implement inviteNewPlayer
    throw UnimplementedError();
  }

  @override
  Stream<InvitationState> stream({required String invitedId}) {
    // TODO: implement stream 
    throw UnimplementedError();
  }

  // @override
  // Future<InvitationState> acceptInvite(Invitation invite) {
  //   // TODO: implement acceptInvite
  //   throw UnimplementedError();
  // }

  // @override
  // Future<InvitationState> denyInvite(Invitation invite) {
  //   // TODO: implement denyInvite
  //   throw UnimplementedError();
  // }

  // Future<bool> _notInvitingSelf(String nickname) async {
  //   final userDoc = await _firestore.collection('usernames').doc(nickname).get();
  //   final user = userDoc.data();
  //   if (user == null) throw Exception('Esse usuário não existe');
  //   if (invite.invitedId == user['username']) throw Exception('Não é possível convidar a sí mesmo.');
  //   return true;
  // }

  // Future<bool> _notInvitingAlreadyInvited(Invitation invite) async {
  //   final documents = await _invitationReference
  //       .where('campaignId', isEqualTo: invite.campaignId)
  //       .where('invitedId', isEqualTo: invite.inviter)
  //       .where('pending', isEqualTo: true)
  //       .limit(1)
  //       .get();

  //   if (documents.docs[0].exists) throw Exception('Esse usuário já tem um convite pendente para a sua campanha.');

  //   return true;
  // }

  // CollectionReference<Invitation> get _invitationReference => _firestore.collection('invites').withConverter(
  //       fromFirestore: (snapshot, _) => InvitationModel.fromMap(snapshot.data()!),
  //       toFirestore: (snapshot, _) => snapshot.toMap(),
  //     );

  // @override
  // Future<InvitationState?> inviteNewPlayer(String nickname, Invitation invite) async {
  //   try {
  //     final notInvitingSelf = await _notInvitingSelf(nickname);
  //     final notInvitingAlreadyInvited = await _notInvitingAlreadyInvited(nickname);
  //     if (!notInvitingSelf && !notInvitingAlreadyInvited) return null;
  //     final inviteDoc = _invitationReference.doc();

  //     await inviteDoc.set(invite.copyWith(
  //       id: inviteDoc.id,
  //       createdAt: DateTime.now(),
  //       pending: true,
  //       accepted: false,
  //     ));

  //     return null;
  //   } catch (e) {
  //     return InvitationErrorState(e.toString());
  //   }
  // }

  // @override
  // Stream<InvitationState> stream({required String invitedId}) {
  //   return _invitationReference.where('createdBy', isEqualTo: invitedId).snapshots().map((snapshot) {
  //     final items = snapshot.docs.map((snapshot) => snapshot.data() as InvitationModel).toList();
  //     if (items.isEmpty) return const InvitationEmptyState();
  //     return InvitationLoadedState(items);
  //   });
  // }
}
