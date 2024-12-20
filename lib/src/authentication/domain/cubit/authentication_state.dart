part of 'authentication_cubit.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class Authenticated<T extends User> extends AuthenticationState {
  const Authenticated({required this.user});

  final T user;

  @override
  List<Object> get props => user.props;
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
