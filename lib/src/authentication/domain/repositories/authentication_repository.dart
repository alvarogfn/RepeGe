import 'package:repege/src/authentication/domain/cubit/authentication_cubit.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  Future<AuthenticationState> signup({
    required String username,
    required String email,
    required String password,
    DateTime? createdAt,
    String? avatarURL,
  });

  Future<AuthenticationState> signin({required String email, required String password});

  Future<AuthenticationState> signout();

  Stream<AuthenticationState> authStateChanges();

  Future<AuthenticationState?> sendEmailVerification();
}
