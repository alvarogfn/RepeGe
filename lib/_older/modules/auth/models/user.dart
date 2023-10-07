import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User {
  late final DocumentReference<User> ref = collection.doc(uid);
  final String username;
  final String uid;
  final String email;
  final bool emailVerified;
  final String? avatarURL;
  final Timestamp? createdAt;
  final String? displayName;
  final String? phoneNumber;

  User({
    required this.username,
    required this.uid,
    required this.email,
    required this.createdAt,
    required this.emailVerified,
    required this.displayName,
    required this.phoneNumber,
    this.avatarURL,
  });

  ImageProvider get avatar {
    if (avatarURL == null) {
      return const AssetImage('assets/images/default_profile_picture.png');
    }
    return NetworkImage(avatarURL!);
  }

  static CollectionReference<User> get collection => FirebaseFirestore.instance.collection('users').withConverter(
        fromFirestore: (
          DocumentSnapshot<Map<String, dynamic>> snapshot,
          SnapshotOptions? options,
        ) {
          final user = snapshot.data()!;
          return User(
            avatarURL: user['avatarURL'],
            email: user['email'],
            uid: user['uid'],
            displayName: user['displayName'],
            emailVerified: user['emailVerified'],
            phoneNumber: user['phoneNumber'],
            username: user['username'],
            createdAt: user['createdAt'],
          );
        },
        toFirestore: (User user, SetOptions? options) {
          return {
            'avatarURL': user.avatarURL,
            'email': user.email,
            'uid': user.uid,
            'username': user.username,
            'ref': user.ref,
            'displayName': user.displayName,
            'emailVerified': user.emailVerified,
            'phoneNumber': user.phoneNumber,
            'createdAt': user.createdAt ?? FieldValue.serverTimestamp()
          };
        },
      );
}
