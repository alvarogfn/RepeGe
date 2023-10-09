part of 'sheet_list_cubit.dart';

sealed class SheetListState extends Equatable {
  const SheetListState();

  @override
  List<Object> get props => [];
}

final class SheetListEmpty extends SheetListState {
  const SheetListEmpty();
}

final class SheetListLoading extends SheetListState {
  const SheetListLoading();
}

final class SheetListLoaded extends SheetListState {
  final List<SheetModel> sheets;

  const SheetListLoaded(this.sheets);

  @override
  List<Object> get props => sheets.map((e) => e.id).toList();
}
