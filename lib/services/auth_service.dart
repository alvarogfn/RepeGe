import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcc/exceptions/auth_exceptions.dart';
import 'package:tcc/models/user_model.dart';

class AuthService {
  static FirebaseAuth instance = FirebaseAuth.instance;
  static final _stream = Stream<UserModel?>.multi((controller) {
    instance.idTokenChanges().listen((user) {
      UserModel? userModel;

      if (user != null) {
        userModel = _toUserModel(user);
      }

      currentUser = userModel;
      controller.add(currentUser);
    });
  });
  static UserModel? currentUser;

  Stream<UserModel?> get userChanges {
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
      await instance.signInWithEmailAndPassword(
          email: email, password: password);
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

  static UserModel _toUserModel(User user) {
    return UserModel(
      uid: user.uid,
      email: user.email!,
    );
  }
}
