import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repege/src/equipments/domain/entities/equipment.dart';
import 'package:repege/src/equipments/domain/repositories/equipment_repository.dart';

part 'equipment_event.dart';
part 'equipment_state.dart';

class EquipmentBloc extends Bloc<EquipmentEvent, EquipmentState> {
  final EquipmentRepository _repository;

  EquipmentBloc(this._repository) : super(const EquipmentStateEmpty()) {
    on<EquipmentInitEvent>((event, emit) {
      emit.onEach(
        stream,
        onData: (equipment) => emit(equipment),
        onError: (error, _) => emit(EquipmentStateError(error.toString())),
      );
    });

    on<EquipmentCreateEvent>((event, emit) async {
      final result = await _repository.create(event.equipment);

      if (result == null) return;

      emit(result);
    });

    on<EquipmentDeleteEvent>((event, emit) async {
      final result = await _repository.delete(event.equipmentId);

      if (result == null) return;

      emit(result);
    });
  }
}
