import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:repege/exceptions/auth_exceptions.dart';
import 'package:repege/models/user_model.dart';

enum AuthState { auth, unauth }

class AuthService with ChangeNotifier {
  final FirebaseAuth instance = FirebaseAuth.instance;
  AuthState state = AuthState.unauth;
  late StreamSubscription _subscription;

  AuthService() {
    _subscription = instance.idTokenChanges().listen((user) {
      LoggedUser? loggedUser;

      if (user != null) {
        loggedUser = _toUserModel(user);
        state = AuthState.auth;
      } else {
        state = AuthState.unauth;
      }

      currentUser = loggedUser;
      notifyListeners();
    });
  }

  LoggedUser? currentUser;

  Future<void> signup({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) throw const AuthException();

      await user.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw const AuthEmailAlreadyUsedException();
        case 'weak-password':
          throw const AuthWeakPasswordException();
        default:
          throw const AuthException();
      }
    } catch (e) {
      throw const AuthException();
    }
  }

  Future<void> signin({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await instance.signInWithEmailAndPassword(
          email: email, password: password);

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
    await instance.signOut();
  }

  LoggedUser _toUserModel(User user) {
    return LoggedUser(
      uid: user.uid,
      email: user.email!,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }
}
