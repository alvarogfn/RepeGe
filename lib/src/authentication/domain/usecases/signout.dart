import 'package:repege/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:repege/core/usecases/usecase.dart';
import 'package:repege/core/utils/typedefs.dart';

class Signout extends UsecaseWithoutParams<ResultFuture<void>> {
  const Signout(this._repository);

  final AuthenticationRepository _repository;

  @override
  call() {
    return _repository.signout();
  }
}
