import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/core/routes/routes_name.dart';
import 'package:repege/src/authentication/domain/entities/user.dart';
import 'package:repege/src/campaigns/domain/bloc/campaigns_bloc.dart';
import 'package:repege/src/campaigns/domain/entities/campaign.dart';

class CampaignListItem extends StatelessWidget {
  const CampaignListItem({
    super.key,
    required this.campaign,
    required this.currentUser,
  });

  final Campaign campaign;
  final User currentUser;

  bool get isOwner => campaign.createdBy == currentUser.id;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => context.pushNamed(Routes.campaign.name, pathParameters: {
          'id': campaign.id,
        }),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ListTile(
              trailing: PopupMenuButton(
                itemBuilder: (context) {
                  return [
                    if (isOwner) ...[
                      PopupMenuItem(
                        child: const Text('Excluir'),
                        onTap: () {
                          final bloc = context.read<CampaignsBloc>();
                          bloc.add(CampaignsDeleteEvent(campaign: campaign));
                        },
                      ),
                    ] else
                      ...[]
                  ];
                },
              ),
              title: Text(
                campaign.name,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: campaign.createdBy == currentUser.id
                  ? const Text('Sua campanha.')
                  : RichText(
                      text: TextSpan(
                        text: 'Mestrado por ',
                        style: Theme.of(context).textTheme.labelMedium,
                        children: [
                          TextSpan(
                            text: campaign.creatorUsername,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
              child: Text(
                campaign.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
