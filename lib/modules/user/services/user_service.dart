import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repege/modules/authentication/services/auth_service.dart';
import 'package:repege/modules/user/services/user.dart';

class UserService {
  UserService._privateConstructor();

  static final UserService _instance = UserService._privateConstructor();

  factory UserService() {
    return _instance;
  }

  final authService = AuthService();

  Stream<User?> stream() {
    final uid = authService.getCurrentUser().uid;

    return collection().doc(uid).snapshots().map((snapshot) {
      return snapshot.data();
    });
  }

  CollectionReference<User> collection() {
    return FirebaseFirestore.instance.collection('users').withConverter(
      fromFirestore: (
        DocumentSnapshot<Map<String, dynamic>> snapshot,
        SnapshotOptions? options,
      ) {
        final user = snapshot.data()!;
        final a = User(
          avatarURL: user['avatarURL'],
          email: user['email'],
          uid: user['uid'],
          ref: snapshot.reference,
          displayName: user['displayName'],
          emailVerified: user['emailVerified'],
          phoneNumber: user['phoneNumber'],
          username: user['username'],
          createdAt: user['createdAt'] ?? Timestamp.fromDate(DateTime.now()),
        );

        return a;
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
