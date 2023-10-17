part of 'campaigns_bloc.dart';

sealed class CampaignsState extends Equatable {
  const CampaignsState();

  @override
  List<Object> get props => [];
}

class CampaignsEmptyState extends CampaignsState {
  const CampaignsEmptyState();
}

class CampaignsLoadingState extends CampaignsState {
  const CampaignsLoadingState();
}

class CampaignsLoadedState extends CampaignsState {
  final List<Campaign> campaigns;

  const CampaignsLoadedState({required this.campaigns});

  @override
  List<Object> get props => [for (var campaign in campaigns) ...campaign.props];
}

class CampaignsErrorState extends CampaignsState {
  final String message;
  const CampaignsErrorState(this.message);

  @override
  List<Object> get props => [message];
}
