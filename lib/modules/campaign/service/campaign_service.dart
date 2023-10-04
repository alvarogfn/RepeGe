import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:repege/modules/campaign/model/campaign.dart';

class CampaignService with ChangeNotifier {
  late DocumentReference<Campaign> campaignReference;

  CampaignService(String campaignId) {
    campaignReference = _collection.doc(campaignId);
  }

  Future<void> bulkUpdate(Map<String, dynamic> data) {
    return campaignReference.update(data);
  }

  Stream<Campaign> stream() {
    return campaignReference.snapshots().map((snapshot) => snapshot.data()!);
  }

  static CollectionReference<Campaign> get _collection {
    return FirebaseFirestore.instance.collection('campaigns').withConverter<Campaign>(
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
