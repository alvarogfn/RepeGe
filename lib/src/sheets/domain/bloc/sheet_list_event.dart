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
  final Sheet sheet;
  final User user;

  const SheetListAddEvent({required this.sheet, required this.user});
}

class SheetListRemoveEvent extends SheetListEvent {
  final String sheetId;
  const SheetListRemoveEvent(this.sheetId);

  @override
  List<Object> get props => [sheetId];
}
