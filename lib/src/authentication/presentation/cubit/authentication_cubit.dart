import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:repege/core/errors/failure.dart';
import 'package:repege/src/authentication/domain/entities/user.dart';
import 'package:repege/src/authentication/domain/usecases/auth_state_changes.dart';
import 'package:repege/src/authentication/domain/usecases/send_email_verification.dart';
import 'package:repege/src/authentication/domain/usecases/signin.dart';
import 'package:repege/src/authentication/domain/usecases/signout.dart';
import 'package:repege/src/authentication/domain/usecases/signup.dart';
part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final Signup _signup;
  final AuthStateChanges _authStateChanges;
  final Signin _signin;
  final Signout _signout;
  final SendEmailVerification _sendEmailVerification;

  late StreamSubscription subscription;

  AuthenticationCubit({
    required AuthStateChanges authStateChanges,
    required Signup signup,
    required Signin signin,
    required Signout signout,
    required SendEmailVerification sendEmailVerification,
  })  : _signup = signup,
        _signin = signin,
        _authStateChanges = authStateChanges,
        _signout = signout,
        _sendEmailVerification = sendEmailVerification,
        super(const Unauthenticated()) {
    _authStateChanges().fold(
      (left) => emit(AuthenticationError(message: left.message)),
      (right) => right.listen((user) {
        if (user == null) return emit(const Unauthenticated());
        if (!user.emailVerified) return emit(Unverified(user: user));
        return emit(Authenticated(user: user));
      }),
    );
  }

  Future<void> signup({
    required String username,
    required String email,
    required String password,
  }) async {
    emit(const AuthenticationLoading());

    final result = await _signup(
      SignupParams(
        username: username,
        email: email,
        password: password,
      ),
    );

    result.fold(
      (failure) => emit(AuthenticationError(message: failure.message)),
      (user) {
        if (user.emailVerified) return emit(Authenticated(user: user));
        return emit(Unverified(user: user));
      },
    );
  }

  Future<void> signin({
    required String email,
    required String password,
  }) async {
    emit(const AuthenticationLoading());

    final result = await _signin(
      SigninParams(
        email: email,
        password: password,
      ),
    );

    result.fold(
      (failure) => emit(AuthenticationError(message: failure.message)),
      (user) {
        if (user.emailVerified) return emit(Authenticated(user: user));
        return emit(Unverified(user: user));
      },
    );
  }

  Future<void> signout() async {
    emit(const AuthenticationLoading());

    final result = await _signout();

    result.fold(
      (failure) => emit(AuthenticationError(message: failure.message)),
      (user) => emit(const Unauthenticated()),
    );
  }

  Future<void> sendEmailVerification() async {
    final result = await _sendEmailVerification();

    if (result.isLeft()) {
      emit(AuthenticationError(message: (result as Failure).message));
    }
  }

  @override
  close() async {
    super.close();
    subscription.cancel();
  }
}
