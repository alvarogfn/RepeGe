part of 'authentication_cubit.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class Authenticated extends AuthenticationState {
  const Authenticated({required this.user});

  final User user;

  @override
  List<Object> get props => [user];
}

final class AuthenticationLoading extends AuthenticationState {
  const AuthenticationLoading();
}

final class Unauthenticated extends AuthenticationState {
  const Unauthenticated();
}

final class AuthenticationError extends AuthenticationState {
  final String message;

  const AuthenticationError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
