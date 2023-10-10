part of 'sheet_list_bloc.dart';

sealed class SheetListEvent extends Equatable {
  const SheetListEvent();

  @override
  List<Object> get props => [];
}

class SheetListInitEvent extends SheetListEvent {
  final String createdBy;
  const SheetListInitEvent(this.createdBy);

  @override
  List<Object> get props => [createdBy];
}

class SheetListAddEvent extends SheetListEvent {
  final String createdBy;
  final int characterLevel;
  final String alignment;
  final String background;
  final String characterClass;
  final String characteristics;
  final String characterName;
  final String characterRace;

  const SheetListAddEvent({
    required this.createdBy,
    required this.characterLevel,
    required this.alignment,
    required this.background,
    required this.characterClass,
    required this.characteristics,
    required this.characterName,
    required this.characterRace,
  });
}

class SheetListRemoveEvent extends SheetListEvent {
  final String sheetId;
  const SheetListRemoveEvent(this.sheetId);

  @override
  List<Object> get props => [sheetId];
}
