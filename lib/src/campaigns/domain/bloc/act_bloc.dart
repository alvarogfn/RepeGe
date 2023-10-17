import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repege/src/campaigns/domain/entities/act.dart';
import 'package:repege/src/campaigns/domain/repositories/campaign_repository.dart';

part 'act_event.dart';
part 'act_state.dart';

class ActBloc extends Bloc<ActEvent, ActState> {
  final CampaignRepository _repository;

  ActBloc(this._repository) : super(const ActLoadingState()) {
    on<ActInitEvent>((event, emit) async {
      await emit.onEach(_repository.streamActs(event.campaignId), onData: (acts) {
        emit(acts);
      });
    });

    on<ActDeleteEvent>((event, emit) async {
      final result = await _repository.deleteAct(event.act);

      if (result == null) return;

      emit(result);
      return;
    });

    on<ActCreateOrUpdateActEvent>((event, emit) async {
      final act = event.act;

      if (act.id == '') {
        final result = await _repository.addAct(act);

        if (result == null) return;

        emit(result);
        return;
      }

      final result = await _repository.updateAct(act);

      if (result == null) return;

      emit(result);
      return;
    });
  }
}
