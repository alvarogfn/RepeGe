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
    this.createdBy = '',
    this.characterLevel = 1,
    this.alignment = '',
    this.background = '',
    this.characterClass = '',
    this.characteristics = '',
    this.characterName = '',
    this.characterRace = '',
  });

  SheetListAddEvent copyWith({
    String? createdBy,
    int? characterLevel,
    String? alignment,
    String? background,
    String? characterClass,
    String? characteristics,
    String? characterName,
    String? characterRace,
  }) {
    return SheetListAddEvent(
      createdBy: createdBy ?? this.createdBy,
      characterLevel: characterLevel ?? this.characterLevel,
      alignment: alignment ?? this.alignment,
      background: background ?? this.background,
      characterClass: characterClass ?? this.characterClass,
      characteristics: characteristics ?? this.characteristics,
      characterName: characterName ?? this.characterName,
      characterRace: characterRace ?? this.characterRace,
    );
  }
}

class SheetListRemoveEvent extends SheetListEvent {
  final String sheetId;
  const SheetListRemoveEvent(this.sheetId);

  @override
  List<Object> get props => [sheetId];
}
