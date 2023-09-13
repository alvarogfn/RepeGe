import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter/material.dart';
import 'package:repege/modules/auth/exceptions/username_exists_exception.dart';
import 'package:repege/modules/auth/models/user.dart';

class AuthService with ChangeNotifier {
  final firebase.FirebaseAuth _firebaseAuth = firebase.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late StreamSubscription _subscription;

  firebase.User? _credential;
  User? _user;

  AuthService() {
    _subscription = _firebaseAuth.authStateChanges().asyncMap((snapshot) async {
      _credential = snapshot;

      if (snapshot == null) throw Exception();

      final user = await User.collection.doc(snapshot.uid).get();

      if (!user.exists) await snapshot.delete();

      return user;
    }).listen((user) {
      _user = user.data();
      notifyListeners();
    }, onError: (_) {
      _user = null;
      notifyListeners();
    });
  }

  User? get user {
    return _user;
  }

  firebase.User? get credential {
    return _credential;
  }

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

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }
}
