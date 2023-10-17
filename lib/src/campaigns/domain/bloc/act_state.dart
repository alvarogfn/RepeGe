part of 'act_bloc.dart';

sealed class ActState extends Equatable {
  const ActState();

  @override
  List<Object> get props => [];
}

final class ActEmptyState extends ActState {
  const ActEmptyState();
}

final class ActLoadingState extends ActState {
  const ActLoadingState();
}

final class ActLoadedState extends ActState {
  final List<Act> acts;
  const ActLoadedState(this.acts);

  @override
  List<Object> get props => [for (var act in acts) ...act.props];
}

final class ActErrorState extends ActState {
  final String message;
  const ActErrorState(this.message);

  @override
  List<Object> get props => [message];
}
