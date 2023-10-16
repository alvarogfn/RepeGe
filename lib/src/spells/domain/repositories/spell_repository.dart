import 'package:repege/src/spells/domain/bloc/spell_bloc.dart';
import 'package:repege/src/spells/domain/entities/spell.dart';

abstract class SpellRepository {
  const SpellRepository();

  Future<SpellState?> create(Spell spell);

  Future<SpellState?> delete(Spell spell);

  Future<SpellState?> update(Spell spell);

  Stream<SpellState> streamAll({required String sheetId});
}
