import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure({required this.message});

  @override
  List<Object> get props => [message];
}

class AuthFailure extends Failure {
  const AuthFailure({required super.message});
}

class SheetFailure extends Failure {
  const SheetFailure({required super.message});
}
