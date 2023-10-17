import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repege/src/campaigns/domain/entities/campaign.dart';
import 'package:repege/src/campaigns/domain/repositories/campaign_repository.dart';

part 'campaign_event.dart';
part 'campaign_state.dart';

class CampaignBloc extends Bloc<CampaignEvent, CampaignState> {
  final CampaignRepository _repository;

  CampaignBloc(this._repository) : super(const CampaignLoadingState()) {
    on<CampaignInitEvent>((event, emit) async {
      await emit.onEach(_repository.stream(event.campaignId), onData: (campaign) {
        emit(campaign);
      });
    });

    on<CampaignUpdateEvent>((event, emit) async {
      final result = await (_repository.update(event.campaign));
      if (result != null) emit(result);
    });
  }
}
