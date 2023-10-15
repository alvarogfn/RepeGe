part of 'equipment_bloc.dart';

sealed class EquipmentState extends Equatable {
  const EquipmentState();

  @override
  List<Object> get props => [];
}

final class EquipmentStateEmpty extends EquipmentState {
  const EquipmentStateEmpty();
}

final class EquipmentStateLoaded<T extends Equipment> extends EquipmentState {
  final List<T> equipments;

  const EquipmentStateLoaded(this.equipments);
}

final class EquipmentStateLoading extends EquipmentState {
  const EquipmentStateLoading();
}

final class EquipmentStateError extends EquipmentState {
  final String message;
  const EquipmentStateError(this.message);
}
