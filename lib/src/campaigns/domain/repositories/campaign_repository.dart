import 'package:repege/src/campaigns/domain/bloc/campaign_bloc.dart';
import 'package:repege/src/campaigns/domain/bloc/campaigns_bloc.dart';
import 'package:repege/src/campaigns/domain/entities/campaign.dart';

abstract class CampaignRepository {
  const CampaignRepository();

  Future<CampaignsState?> create(Campaign campaign);

  Future<CampaignsState?> delete(String campaignId);

  Stream<CampaignsState> streamAll({required String createdBy});

  Stream<CampaignState> stream(String campaignId);

  Future<CampaignState?> update(Campaign campaign);
}
