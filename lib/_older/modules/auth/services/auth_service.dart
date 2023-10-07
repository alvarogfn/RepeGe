import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:repege/modules/auth/exceptions/username_exists_exception.dart';
import 'package:repege/modules/auth/models/user.dart' as local;

class AuthService with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late StreamSubscription _subscription;

  User? user;

  AuthService(this.user);

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<bool> checkIfUsernameExists(String username) async {
    try {
      final usernameDoc = await FirebaseFirestore.instance.collection('usernames').doc(username).get();
      return usernameDoc.exists;
    } catch (e) {
      return false;
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    final usernameExists = await checkIfUsernameExists(username);
    if (usernameExists) throw UsernameExistsException();

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
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<local.User?> getCurrentFirestoreUser() async {
    if (user == null) return null;
    final firestoreUser = await local.User.collection.doc(user!.uid).get();
    return firestoreUser.data()!;
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }
}
