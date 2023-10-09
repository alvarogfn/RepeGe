part of 'sheets_cubit.dart';

sealed class SheetsState extends Equatable {
  const SheetsState();

  @override
  List<Object> get props => [];
}

final class SheetsInitialState extends SheetsState {
  const SheetsInitialState();
}

final class SheetsCreated extends SheetsState {
  final SheetModel sheet;
  const SheetsCreated(this.sheet);
}

final class SheetsError extends SheetsState {
  final String message;
  const SheetsError(this.message);
}

final class SheetsDeleted extends SheetsState {
  const SheetsDeleted();
}
