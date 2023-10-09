import 'package:equatable/equatable.dart';
import 'package:repege/src/authentication/domain/entities/user.dart';
import 'package:repege/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:repege/core/usecases/usecase.dart';
import 'package:repege/core/utils/typedefs.dart';

class Signup extends UsecaseWithParams<ResultFuture<User>, SignupParams> {
  const Signup(this._repository);

  final AuthenticationRepository _repository;

  @override
  call(params) {
    return _repository.signup(
      password: params.password,
      createdAt: params.createdAt,
      email: params.email,
      username: params.username,
      avatarURL: params.avatarURL,
    );
  }
}

class SignupParams extends Equatable {
  final String username;
  final String password;
  final String email;
  final String? avatarURL;
  final DateTime? createdAt;

  const SignupParams({
    required this.username,
    required this.email,
    required this.password,
    this.createdAt,
    this.avatarURL,
  });

  @override
  List<Object?> get props => [username, password, email, avatarURL, createdAt];
}
