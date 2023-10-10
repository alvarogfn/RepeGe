import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repege/src/authentication/domain/entities/user.dart';
import 'package:repege/src/authentication/domain/repositories/authentication_repository.dart';
part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthenticationRepository _repository;
  late final StreamSubscription _subscription;

  AuthenticationCubit(this._repository) : super(const Unauthenticated()) {
    _subscription = _repository.authStateChanges().listen((event) => emit(event));
  }

  Future<void> signup({
    required String username,
    required String email,
    required String password,
  }) async {
    emit(const AuthenticationLoading());

    final result = await _repository.signup(
      email: email,
      username: username,
      password: password,
    );

    emit(result);
  }

  Future<void> signin({
    required String email,
    required String password,
  }) async {
    emit(const AuthenticationLoading());

    final result = await _repository.signin(
      email: email,
      password: password,
    );

    emit(result);
  }

  Future<void> signout() async {
    emit(const AuthenticationLoading());

    final result = await _repository.signout();
    emit(result);
  }

  Future<void> sendEmailVerification() async {
    final result = await _repository.sendEmailVerification();

    if (result != null) emit(result);
  }

  @override
  close() async {
    super.close();
    _subscription.cancel();
  }
}
