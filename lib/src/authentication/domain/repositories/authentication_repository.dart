import 'package:repege/src/authentication/domain/entities/user.dart';
import 'package:repege/core/utils/typedefs.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  ResultFuture<User> signup({
    required String username,
    required String email,
    required String password,
    DateTime? createdAt,
    String? avatarURL,
  });

  ResultFuture<User> signin({required String email, required String password});

  ResultVoid signout();

  ResultStream<User?> authStateChanges();

  ResultVoid sendEmailVerification();
}
