import 'package:repege/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:repege/core/usecases/usecase.dart';
import 'package:repege/core/utils/typedefs.dart';

class Signout extends UsecaseWithoutParams<void> {
  const Signout(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture<void> call() {
    return _repository.signout();
  }
}
