import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:repege/modules/user/services/user.dart';

class UserService {
  late final DocumentReference<User> user;
  late final bool hasEmailVerified;

  UserService(firebase.User user) {
    this.user = collection().doc(user.uid);
    hasEmailVerified = user.emailVerified;
  }

  Stream<User> stream() {
    return user.snapshots().map((snapshot) {
      return snapshot.data()!;
    });
  }

  CollectionReference<User> collection() {
    return FirebaseFirestore.instance.collection('users').withConverter(
      fromFirestore: (
        DocumentSnapshot<Map<String, dynamic>> snapshot,
        SnapshotOptions? options,
      ) {
        final user = snapshot.data()!;

        return User(
          avatarURL: user['avatarURL'],
          email: user['email'],
          uid: user['uid'],
          // TODO: encontrar um jeito melhor de fazer isso;
          ref: collection().doc(snapshot.id),
          displayName: user['displayName'],
          emailVerified: user['emailVerified'],
          phoneNumber: user['phoneNumber'],
          username: user['username'],
          createdAt: user['createdAt'] ?? Timestamp.fromDate(DateTime.now()),
        );
      },
      toFirestore: (User user, SetOptions? options) {
        return {
          'avatarURL': user.avatarURL,
          'email': user.email,
          'uid': user.uid,
          'username': user.username,
          'displayName': user.displayName,
          'emailVerified': user.emailVerified,
          'phoneNumber': user.phoneNumber,
          'createdAt': FieldValue.serverTimestamp()
        };
      },
    );
  }
}
