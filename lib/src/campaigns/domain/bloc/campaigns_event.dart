part of 'campaigns_bloc.dart';

sealed class CampaignsEvent extends Equatable {
  const CampaignsEvent();

  @override
  List<Object> get props => [];
}

class CampaignsInitEvent extends CampaignsEvent {
  final String userId;

  const CampaignsInitEvent({required this.userId});
}

class CampaignsCreateEvent extends CampaignsEvent {
  final Campaign campaign;
  final User user;

  const CampaignsCreateEvent({required this.campaign, required this.user});
}

class CampaignsDeleteEvent extends CampaignsEvent {
  final Campaign campaign;

  const CampaignsDeleteEvent({required this.campaign});
}


class CampaignsErrorEvent extends CampaignsEvent {
  final String message;

  const CampaignsErrorEvent({required this.message});
}
