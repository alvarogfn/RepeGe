part of 'campaign_bloc.dart';

sealed class CampaignState extends Equatable {
  const CampaignState();

  @override
  List<Object> get props => [];
}

class CampaignLoadingState extends CampaignState {
  const CampaignLoadingState();
}

class CampaignUpdatedState extends CampaignState {
  final Campaign campaign;
  const CampaignUpdatedState(this.campaign);
}

class CampaignLoadedState extends CampaignState {
  final Campaign campaign;
  const CampaignLoadedState(this.campaign);
}

class CampaignErrorState extends CampaignState {
  final String message;
  const CampaignErrorState(this.message);
}
