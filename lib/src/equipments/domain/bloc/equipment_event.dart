part of 'equipment_bloc.dart';

sealed class EquipmentEvent extends Equatable {
  const EquipmentEvent();

  @override
  List<Object> get props => [];
}

class EquipmentCreateEvent<T extends Equipment> extends EquipmentEvent {
  final T equipment;
  const EquipmentCreateEvent(this.equipment);

  @override
  List<Object> get props => equipment.props;
}

class EquipmentInitEvent extends EquipmentEvent {
  final String sheetId;
  const EquipmentInitEvent(this.sheetId);

  @override
  List<Object> get props => [sheetId];
}

class EquipmentDeleteEvent extends EquipmentEvent {
  final Equipment equipment;

  const EquipmentDeleteEvent(this.equipment);

  @override
  List<Object> get props => [equipment];
}
