import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'username_state.dart';

class UsernameCubit extends Cubit<UsernameState> {
  UsernameCubit() : super(UsernameInitial());

  Future<void> getAlreadyInvitedState() async {}
  Future<void> getIsCurrentAuthenticatedUser() async {}
}
