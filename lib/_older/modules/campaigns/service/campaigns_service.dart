import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repege/modules/auth/services/auth_service.dart';
import 'package:repege/modules/campaign/model/campaign.dart';

class CampaignsService extends ChangeNotifier {
  AuthService authService;

  CampaignsService(this.authService);

  Future<Campaign> add(Map<String, dynamic> data) async {
    final ref = collection.doc();

    final firebaseUser = await authService.getCurrentFirestoreUser();

    final campaign = Campaign(
      sheets: [],
      participants: [authService.user!.uid],
      description: data['description'],
      name: data['name'],
      ownerRef: firebaseUser!.ref,
      ownerUID: authService.user!.uid,
      id: ref.id,
      ref: ref,
    );

    await ref.set(campaign);

    return campaign;
  }

  Stream<Campaign> streamOf(String campaignId) {
    return collection.doc(campaignId).snapshots().map((event) => event.data()!);
  }

  Stream<List<Campaign>> streamAll() {
    final snapshots = collection.snapshots();

    return snapshots.map((snapshots) {
      return snapshots.docs.map((doc) {
        final sheet = doc.data();
        return sheet;
      }).toList();
    });
  }

  Future<DocumentSnapshot<Campaign>> get(String id) async {
    return collection.doc(id).get();
  }

  CollectionReference<Campaign> get collection {
    return FirebaseFirestore.instance.collection('campaigns').withConverter(
          fromFirestore: (snapshot, _) {
            final campaignMap = snapshot.data()!;
            campaignMap.putIfAbsent('id', () => snapshot.id);
            campaignMap.putIfAbsent('ref', () => snapshot.reference);

            return Campaign.fromMap(campaignMap);
          },
          toFirestore: (campaign, _) => campaign.toMap()..putIfAbsent('createdAt', () => FieldValue.serverTimestamp()),
        );
  }
}
