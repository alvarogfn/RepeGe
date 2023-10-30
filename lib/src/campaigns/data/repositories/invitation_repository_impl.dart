import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:repege/src/authentication/data/models/user_model.dart';
import 'package:repege/src/campaigns/data/model/campaign_model.dart';
import 'package:repege/src/campaigns/data/model/invitation_model.dart';
import 'package:repege/src/campaigns/domain/bloc/invitation_bloc.dart';
import 'package:repege/src/campaigns/domain/entities/campaign.dart';
import 'package:repege/src/campaigns/domain/entities/invitation.dart';
import 'package:repege/src/campaigns/domain/repositories/invitation_repository.dart';

class InvitationRepositoryImpl extends InvitationRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  InvitationRepositoryImpl(this._firestore, this._auth);

  @override
  Future<InvitationState?> acceptInvite(Invitation invite) async {
    try {
      final acceptedInvite = invite.copyWith(
        pending: false,
        accepted: true,
      );

      final batch = _firestore.batch();

      batch.set(invitationCollection.doc(invite.id), acceptedInvite);

      final campaignSnapshot = await campaignsCollection.doc(invite.campaignId).get();

      final campaign = campaignSnapshot.data()!;

      batch.set(
        campaignSnapshot.reference,
        campaign.copyWith(
          users: campaign.users..add(invite.guest),
          sheetsId: campaign.sheetsId..add(invite.sheetId!),
        ),
      );

      await batch.commit();

      return null;
    } catch (e) {
      return InvitationErrorState(e.toString());
    }
  }

  Future<InvitationState?> _verifyIfIsNotInCampaignAlready({required String userId, required String campaignId}) async {
    final campaignSnapshot = await campaignsCollection.doc(campaignId).get();
    final campaign = campaignSnapshot.data()!;

    if (campaign.users.contains(userId)) {
      return const InvitationErrorState('Não é possível convidar alguém que já está na campanha');
    }

    return null;
  }

  @override
  Future<InvitationState?> createInvite({required Invitation invite, required String username}) async {
    try {
      final user = await _getUserByUsername(username);

      final result = await _verifyIfIsNotInCampaignAlready(
        campaignId: invite.campaignId,
        userId: user.id,
      );

      if (result != null) return result;

      final newInviteDoc = invitationCollection.doc();

      await newInviteDoc.set(invite.copyWith(
        guest: user.id,
        inviter: _auth.currentUser!.uid,
        createdAt: DateTime.now(),
        pending: true,
        accepted: false,
        id: newInviteDoc.id,
        sheetId: null,
      ));

      return null;
    } catch (e) {
      return InvitationErrorState(e.toString());
    }
  }

  @override
  Future<InvitationState?> denyInvite(Invitation invite) async {
    try {
      final deniedInvite = invite.copyWith(
        pending: false,
        accepted: false,
        sheetId: null,
      );

      await invitationCollection.doc(invite.id).set(deniedInvite);

      return null;
    } catch (e) {
      return InvitationErrorState(e.toString());
    }
  }

  @override
  Stream<InvitationState> stream({required String guest}) {
    try {
      return invitationCollection
          .where('guest', isEqualTo: guest)
          .where('pending', isEqualTo: true)
          .snapshots()
          .map((query) {
        return InvitationLoadedState(
          query.docs.map((snapshot) {
            return snapshot.data() as InvitationModel;
          }).toList(),
        );
      });
    } catch (e) {
      return Stream.value(InvitationErrorState(e.toString()));
    }
  }

  Future<UserModel> _getUserByUsername(String username) async {
    final usernameDoc = await _firestore.collection('usernames').doc(username).get();

    final usernameData = usernameDoc.data()!;
    final userId = usernameData['createdBy'];

    final user = await _firestore.collection('users').doc(userId).get();

    return UserModel.fromMap(user.data()!);
  }

  @override
  Future<InvitationState?> verifyUsername(String username) async {
    try {
      final usernameDoc = await _firestore.collection('usernames').doc(username).get();

      if (!usernameDoc.exists) throw Exception('Esse nome de usuário não existe.');

      final usernameData = usernameDoc.data()!;
      final userId = usernameData['createdBy'];

      if (userId == _auth.currentUser!.uid) {
        return const InvitationErrorState(
          'Não é possível convidar a sí mesmo',
        );
      }

      final pendingInvites = await invitationCollection
          .where('guest', isEqualTo: userId)
          .where(
            'pending',
            isEqualTo: true,
          )
          .count()
          .get();

      if (pendingInvites.count > 0) {
        return const InvitationErrorState(
          'Não é possível convidar alguém já convidado.',
        );
      }

      return null;
    } catch (e) {
      return InvitationErrorState(e.toString());
    }
  }

  CollectionReference<Invitation> get invitationCollection => _firestore.collection('invites').withConverter(
        fromFirestore: (snapshot, _) => InvitationModel.fromMap(snapshot.data()!),
        toFirestore: (snapshot, _) => snapshot.toMap(),
      );
  CollectionReference<Campaign> get campaignsCollection => _firestore.collection('campaigns').withConverter(
        fromFirestore: (snapshot, _) => CampaignModel.fromMap(snapshot.data()!),
        toFirestore: (snapshot, _) => snapshot.toMap(),
      );
}
