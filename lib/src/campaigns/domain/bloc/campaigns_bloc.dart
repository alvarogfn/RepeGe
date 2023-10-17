import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repege/src/authentication/domain/entities/user.dart';
import 'package:repege/src/campaigns/domain/entities/campaign.dart';
import 'package:repege/src/campaigns/domain/repositories/campaign_repository.dart';

part 'campaigns_event.dart';
part 'campaigns_state.dart';

class CampaignsBloc extends Bloc<CampaignsEvent, CampaignsState> {
  final CampaignRepository _repository;

  CampaignsBloc(this._repository) : super(const CampaignsEmptyState()) {
    on<CampaignsInitEvent>((event, emit) async {
      await emit.onEach(
        _repository.streamAll(createdBy: event.createdBy),
        onData: (campaign) => emit(campaign),
      );
    });

    on<CampaignsCreateEvent>((event, emit) async {
      final result = await _repository.create(
        event.campaign.copyWith(
          createdBy: event.user.id,
          createdAt: DateTime.now(),
        ),
      );

      if (result != null) emit(result);
    });

    on<CampaignsDeleteEvent>((event, emit) async {
      final result = await _repository.delete(event.campaign.id);

      if (result != null) emit(result);
    });
  }
}
