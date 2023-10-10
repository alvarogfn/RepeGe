part of 'sheet_update_cubit.dart';

sealed class SheetUpdateState extends Equatable {
  const SheetUpdateState();

  @override
  List<Object> get props => [];
}

final class SheetUpdateInit extends SheetUpdateState {
  const SheetUpdateInit();
}

final class SheetUpdateSucess extends SheetUpdateState {
  final key = Random().nextDouble();
  SheetUpdateSucess();

  @override
  List<Object> get props => [key];
}

final class SheetUpdateError extends SheetUpdateState {
  const SheetUpdateError();
}
