import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService._privateConstructor();

  static final AuthService _instance = AuthService._privateConstructor();

  factory AuthService() {
    return _instance;
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> stream() {
    return _firebaseAuth.idTokenChanges();
  }

  User getCurrentUser() {
    final currentUser = _firebaseAuth.currentUser;

    if (currentUser == null) throw Exception();

    return currentUser;
  }

  static Future<bool> checkIfUsernameExists(String username) async {
    try {
      final usernameDoc = await FirebaseFirestore.instance
          .collection('usernames')
          .doc(username)
          .get();

      return usernameDoc.exists;
    } catch (e) {
      return false;
    }
  }

  FutureOr<void> sendEmailVerification() {
    if (_firebaseAuth.currentUser?.emailVerified == false) {
      _firebaseAuth.currentUser?.sendEmailVerification();
      return _firebaseAuth.signOut();
    }
  }

  Future<bool> signin({
    required String email,
    required String password,
  }) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user;

    if (user != null && !user.emailVerified) {
      throw Exception();
    }

    return true;
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  Future<bool> signup({
    required String email,
    required String password,
    required String username,
  }) async {
    final usernameExists = await checkIfUsernameExists(username);
    if (usernameExists) throw Exception();

    final batch = _firestore.batch();

    final usernameReference = _firestore.collection('usernames').doc(username);

    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user;
    if (user == null) throw Exception();

    final userReference = _firestore.collection('users').doc(user.uid);

    batch.set(usernameReference, {
      'ref': userReference,
    });

    batch.set(userReference, {
      'username': username,
      'uid': user.uid,
      'email': user.email,
      'emailVerified': user.emailVerified,
      'displayName': user.displayName,
      'phoneNumber': user.phoneNumber,
      'avatarURL': user.photoURL,
      'createdAt': FieldValue.serverTimestamp(),
    });

    await user.sendEmailVerification();

    await batch.commit().catchError((_) => user.delete());

    return true;
  }

  bool get isAuthenticated {
    return _firebaseAuth.currentUser != null;
  }
}
