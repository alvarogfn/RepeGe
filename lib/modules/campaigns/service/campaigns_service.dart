import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:repege/modules/campaign/model/campaign.dart';

class CampaignsService extends ChangeNotifier {
  User user;

  CampaignsService(this.user);

  Stream<Campaign> streamOf(String campaignId) {
    return collection.doc(campaignId).snapshots().map((event) => event.data()!);
  }

  Stream<List<Campaign>> streamAll() {
    final snapshots = collection.where('ownerUID', isEqualTo: user.uid).snapshots();

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
    return FirebaseFirestore.instance.collection('sheets').withConverter(
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
