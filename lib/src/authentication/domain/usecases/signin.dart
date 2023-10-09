import 'package:equatable/equatable.dart';
import 'package:repege/src/authentication/domain/entities/user.dart';

import 'package:repege/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:repege/core/usecases/usecase.dart';
import 'package:repege/core/utils/typedefs.dart';

class Signin extends UsecaseWithParams<ResultFuture<User>, SigninParams> {
  const Signin(this._repository);

  final AuthenticationRepository _repository;

  @override
  call(params) {
    return _repository.signin(email: params.email, password: params.password);
  }
}

class SigninParams extends Equatable {
  final String email;
  final String password;

  const SigninParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}
