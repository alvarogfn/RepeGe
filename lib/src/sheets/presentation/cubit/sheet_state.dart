part of 'sheet_cubit.dart';

sealed class SheetState extends Equatable {
  const SheetState();

  @override
  List<Object> get props => [];
}

final class SheetLoading extends SheetState {
  const SheetLoading();
}

final class SheetLoaded extends SheetState {
  final SheetModel sheet;

  const SheetLoaded(this.sheet);

  @override
  List<Object> get props => [...sheet.props];
}

final class SheetError extends SheetState {
  final String message;

  const SheetError(this.message);

  @override
  List<Object> get props => [message];
}

final class SheetUpdated extends SheetState {
  const SheetUpdated();
}
