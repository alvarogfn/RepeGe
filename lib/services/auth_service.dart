import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcc/exceptions/auth_exceptions.dart';
import 'package:tcc/models/user_model.dart';

class AuthService {
  static FirebaseAuth instance = FirebaseAuth.instance;
  static final _stream = Stream<LoggedUser?>.multi((controller) {
    instance.idTokenChanges().listen((user) {
      LoggedUser? loggedUser;

      if (user != null) {
        loggedUser = _toUserModel(user);
      }

      currentUser = loggedUser;
      controller.add(currentUser);
    });
  });
  static LoggedUser? currentUser;

  Stream<LoggedUser?> get userChanges {
    return _stream;
  }

  static Future<void> signup({
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

  static Future<void> signin({
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

  static Future<void> logout() async {
    await instance.signOut();
  }

  static LoggedUser _toUserModel(User user) {
    return LoggedUser(
      uid: user.uid,
      email: user.email!,
    );
  }
}
