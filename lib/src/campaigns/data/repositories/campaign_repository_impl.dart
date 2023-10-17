import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:repege/src/campaigns/data/model/campaign_model.dart';
import 'package:repege/src/campaigns/domain/bloc/campaign_bloc.dart';
import 'package:repege/src/campaigns/domain/bloc/campaigns_bloc.dart';
import 'package:repege/src/campaigns/domain/entities/campaign.dart';
import 'package:repege/src/campaigns/domain/repositories/campaign_repository.dart';

class CampaignRepositoryImpl extends CampaignRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  const CampaignRepositoryImpl(this._firestore, this._auth);

  @override
  Future<CampaignsState?> create(Campaign campaign) async {
    final reference = _collectionReference.doc();

    try {
      await reference.set(
        campaign.copyWith(
          id: reference.id,
          createdBy: _auth.currentUser!.uid,
          createdAt: DateTime.now(),
          users: [_auth.currentUser!.uid],
        ),
      );

      return null;
    } catch (e) {
      return CampaignsErrorState(e.toString());
    }
  }

  @override
  Future<CampaignsState?> delete(String campaignId) async {
    try {
      await _collectionReference.doc(campaignId).delete();
      return null;
    } catch (e) {
      return CampaignsErrorState(e.toString());
    }
  }

  @override
  Stream<CampaignsState> streamAll({required String userId}) {
    return _collectionReference.where('users', arrayContains: userId).snapshots().map((snapshot) {
      final items = snapshot.docs.map((snapshot) => snapshot.data() as CampaignModel).toList();
      if (items.isEmpty) return const CampaignsEmptyState();
      return CampaignsLoadedState(campaigns: items);
    });
  }

  @override
  Stream<CampaignState> stream(String campaignId) {
    return _collectionReference.doc(campaignId).snapshots().map((snapshot) => CampaignLoadedState(snapshot.data()!));
  }

  @override
  Future<CampaignState?> update(Campaign campaign) async {
    try {
      await _collectionReference.doc(campaign.id).set(campaign);
      return CampaignUpdatedState(campaign);
    } catch (e) {
      return CampaignErrorState(e.toString());
    }
  }

  CollectionReference<Campaign> get _collectionReference {
    return _firestore.collection('campaigns').withConverter(
        fromFirestore: ((snapshot, options) => CampaignModel.fromMap(snapshot.data()!)),
        toFirestore: (snapshot, options) => snapshot.toMap());
  }
}
