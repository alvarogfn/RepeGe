import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class User {
  final DocumentReference ref;
  final String username;
  final String uid;
  final String email;
  final String? avatarURL;
  final Timestamp createdAt;
  final bool emailVerified;
  final String? displayName;
  final String? phoneNumber;

  late final _bucketRef = FirebaseStorage.instance.ref('users/$uid/');

  User({
    required this.username,
    required this.uid,
    required this.email,
    required this.createdAt,
    required this.ref,
    required this.emailVerified,
    required this.displayName,
    required this.phoneNumber,
    this.avatarURL,
  });

  Future<String> updateAvatar(File newAvatar) async {
    final ext = newAvatar.path.split('.').last;
    final upload = await _bucketRef.child('avatar.$ext').putFile(
          newAvatar,
          SettableMetadata(contentType: 'image/$ext'),
        );

    final url = await upload.ref.getDownloadURL();

    await ref.update({'avatarURL': url});

    return url;
  }

  ImageProvider get avatar {
    if (avatarURL == null) {
      return const AssetImage('assets/images/default_profile_picture.png');
    }
    return NetworkImage(avatarURL!);
  }
}
