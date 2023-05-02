import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:repege/exceptions/auth_exceptions.dart';
import 'package:repege/models/user.dart' as local;
import 'package:repege/environment_variables.dart';

enum AuthState { auth, unauth }

class AuthService with ChangeNotifier {
  final FirebaseAuth _instance = FirebaseAuth.instance;

  late AuthState state;

  late StreamSubscription _subscription;

  local.User? user;

  AuthService() {
    state = _instance.currentUser != null ? AuthState.auth : AuthState.unauth;

    _subscription = _instance.idTokenChanges().listen((current) {
      if (current != null) {
        local.User.get(current.uid).then((value) => user = value);
      }

      if (user != null) {
        state = AuthState.auth;
      } else {
        state = AuthState.unauth;
      }

      notifyListeners();
    });
  }

  Future<void> signup({
    required String email,
    required String password,
    required String username,
  }) async {
    User? credentialUser;

    try {
      final usernameExists = await checkIfUsernameExists(username);
      if (usernameExists) throw const AuthUsernameAlreadyUsedException();

      final credential = await _instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      credentialUser = credential.user;
      if (credentialUser == null) throw const AuthException();

      await local.User.create(
        username: username,
        email: email,
        uid: credentialUser.uid,
        avatarURL: credentialUser.photoURL,
      );

      if (EnvironmentVariables.production) {
        await credentialUser.sendEmailVerification();
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw const AuthEmailAlreadyUsedException();
        case 'weak-password':
          throw const AuthWeakPasswordException();
        default:
          throw const AuthException();
      }
    } on AuthException catch (_) {
      rethrow;
    } catch (e) {
      await credentialUser?.delete();
      throw const AuthException();
    }
  }

  Future<void> signin({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;

      if (user != null && !user.emailVerified) {
        throw const AuthEmailNotVerifiedException();
      }
    } on AuthEmailNotVerifiedException catch (_) {
      rethrow;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw const AuthMismatchLoginException();
        default:
          throw const AuthException();
      }
    } catch (e) {
      throw const AuthException();
    }
  }

  Future<void> logout() async {
    await _instance.signOut();
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  Future<void> refresh() async {
    notifyListeners();
    return await _instance.currentUser?.reload();
  }

  static Future<bool> checkIfUsernameExists(String username) async {
    try {
      final usernameDoc = await FirebaseFirestore.instance
          .collection("usernames")
          .doc(username)
          .get();

      return usernameDoc.exists;
    } catch (e) {
      return false;
    }
  }
}
