part of 'sheet_list_bloc.dart';

sealed class SheetListState<T extends Sheet> extends Equatable {
  final List<T> sheets;

  const SheetListState([this.sheets = const []]);

  @override
  List<Object> get props => sheets.map((e) => e.id).toList();
}

final class SheetListEmpty extends SheetListState {
  const SheetListEmpty();
}

final class SheetListLoading extends SheetListState {
  const SheetListLoading();
}

final class SheetListLoadError extends SheetListState {}

final class SheetListLoaded<T extends Sheet> extends SheetListState {
  @override
  // ignore: overridden_fields
  final List<T> sheets;

  const SheetListLoaded(this.sheets);
}
