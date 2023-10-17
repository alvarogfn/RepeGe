part of 'campaign_bloc.dart';

sealed class CampaignEvent extends Equatable {
  const CampaignEvent();

  @override
  List<Object> get props => [];
}

class CampaignUpdateEvent extends CampaignEvent {
  final Campaign campaign;
  const CampaignUpdateEvent(this.campaign);

  @override
  List<Object> get props => campaign.props;
}

class CampaignInitEvent extends CampaignEvent {
  final String campaignId;
  const CampaignInitEvent(this.campaignId);

  @override
  List<Object> get props => [campaignId];
}
