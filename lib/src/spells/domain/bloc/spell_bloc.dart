import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repege/src/spells/domain/entities/spell.dart';
import 'package:repege/src/spells/domain/repositories/spell_repository.dart';

part 'spell_event.dart';
part 'spell_state.dart';

class SpellBloc extends Bloc<SpellEvent, SpellState> {
  final SpellRepository _repository;

  SpellBloc(this._repository) : super(const SpellStateEmpty()) {
    on<SpellInitEvent>((event, emit) async {
      await emit.onEach(
        _repository.streamAll(sheetId: event.sheetId),
        onData: (spell) => emit(spell),
        onError: (error, _) => emit(SpellStateError(error.toString())),
      );
    });

    on<SpellCreateEvent>((event, emit) async {
      final result = await _repository.create(event.spell);

      if (result == null) return;

      emit(result);
    });

    on<SpellDeleteEvent>((event, emit) async {
      final result = await _repository.delete(event.spell);

      if (result == null) return;

      emit(result);
    });
  }
}
