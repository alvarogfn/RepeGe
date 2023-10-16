part of 'spell_bloc.dart';

sealed class SpellState extends Equatable {
  const SpellState();

  @override
  List<Object> get props => [];
}

final class SpellStateEmpty extends SpellState {
  const SpellStateEmpty();
}

final class SpellStateLoaded extends SpellState {
  final List<Spell> spells;

  const SpellStateLoaded(this.spells);

  @override
  List<Object> get props => [for (var spell in spells) ...spell.props];
}

final class SpellStateLoading extends SpellState {
  const SpellStateLoading();
}

final class SpellStateError extends SpellState {
  final String message;
  const SpellStateError(this.message);

  @override
  List<Object> get props => [message];
}
