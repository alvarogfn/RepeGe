part of 'sheet_list_bloc.dart';

sealed class SheetListState<T extends Sheet> extends Equatable {
  final List<T> sheets;

  const SheetListState([this.sheets = const []]);

  @override
  List<Object> get props => sheets.map((e) => e.id).toList();
}

final class SheetListEmpty<T extends Sheet> extends SheetListState<T> {
  const SheetListEmpty();
}

final class SheetListLoading<T extends Sheet> extends SheetListState<T> {
  const SheetListLoading();
}

final class SheetListLoadError<T extends Sheet> extends SheetListState<T> {}

final class SheetListLoaded<T extends Sheet> extends SheetListState<T> {
  @override
  // ignore: overridden_fields
  final List<T> sheets;

  const SheetListLoaded(this.sheets);

  @override
  List<Object> get props => [for (var sheet in sheets) ...sheet.props];
}
