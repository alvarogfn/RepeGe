import 'package:repege/src/authentication/domain/entities/user.dart';
import 'package:repege/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:repege/core/usecases/usecase.dart';
import 'package:repege/core/utils/typedefs.dart';

class AuthStateChanges extends UsecaseWithoutParams<ResultStream<User?>> {
  const AuthStateChanges(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultStream<User?> call() {
    return _repository.authStateChanges();
  }
}
