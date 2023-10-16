part of 'spell_bloc.dart';

sealed class SpellEvent extends Equatable {
  const SpellEvent();

  @override
  List<Object> get props => [];
}

class SpellCreateEvent<T extends Spell> extends SpellEvent {
  final T spell;
  const SpellCreateEvent(this.spell);

  @override
  List<Object> get props => spell.props;
}

class SpellInitEvent extends SpellEvent {
  final String sheetId;
  const SpellInitEvent(this.sheetId);

  @override
  List<Object> get props => [sheetId];
}

class SpellDeleteEvent extends SpellEvent {
  final Spell spell;

  const SpellDeleteEvent(this.spell);

  @override
  List<Object> get props => spell.props;
}
