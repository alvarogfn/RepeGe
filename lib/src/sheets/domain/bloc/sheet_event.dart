part of 'sheet_bloc.dart';

sealed class SheetEvent extends Equatable {
  const SheetEvent();

  @override
  List<Object> get props => [];
}

class SheetInitEvent extends SheetEvent {
  final String sheetId;
  const SheetInitEvent(this.sheetId);

  @override
  List<Object> get props => [sheetId];
}
