part of 'sheets_cubit.dart';

sealed class SheetsState extends Equatable {
  const SheetsState();

  @override
  List<Object> get props => [];
}

final class SheetsLoading extends SheetsState {
  const SheetsLoading();
}

final class SheetsDeleted extends SheetsState {
  const SheetsDeleted();
}

final class SheetsList extends SheetsState {
  final List<Sheet> sheets;

  const SheetsList(this.sheets);
}

final class SheetsError extends SheetsState {
  const SheetsError();
}
