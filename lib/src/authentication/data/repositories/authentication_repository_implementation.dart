import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:repege/src/authentication/domain/entities/user.dart';
import 'package:repege/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:repege/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:repege/core/errors/failure.dart';

import 'package:repege/core/utils/typedefs.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationRemoteDataSource _remoteDataSource;

  AuthenticationRepositoryImpl(this._remoteDataSource);

  @override
  ResultFuture<User> signup({
    required username,
    required password,
    required email,
    createdAt,
    avatarURL,
  }) async {
    try {
      final user = await _remoteDataSource.signup(
        username: username,
        password: password,
        email: email,
        createdAt: createdAt,
        avatarURL: avatarURL,
      );
      return Right(user);
    } catch (e) {
      if (e is auth.FirebaseAuthException) {
        return Left(AuthFailure(message: e.message!));
      }

      return Left(AuthFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<User> signin({required String email, required String password}) async {
    try {
      final user = await _remoteDataSource.signin(email: email, password: password);
      return Right(user);
    } catch (e) {
      return Left(AuthFailure(message: e.toString()));
    }
  }

  @override
  ResultStream<User?> authStateChanges() {
    return _remoteDataSource
        .authStateChanges()
        .handleError((error) => Left(AuthFailure(message: error.toString())))
        .asyncMap((event) => Right(event));
  }

  @override
  ResultVoid signout() async {
    try {
      await _remoteDataSource.signout();
      return const Right(null);
    } catch (e) {
      return Left(AuthFailure(message: e.toString()));
    }
  }

  @override
  ResultVoid sendEmailVerification() async {
    try {
      await _remoteDataSource.sendEmailVerification();
      return const Right(null);
    } catch (e) {
      return Left(AuthFailure(message: e.toString()));
    }
  }
}
