import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/src/miscellaneous/presentation/widgets/app_drawer.dart';

class CampaingsScreen extends StatelessWidget {
  const CampaingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campanhas'),
        actions: [
          IconButton(
            onPressed: () => context.pushNamed(RoutesName.campaignsCreate.name),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: ChangeNotifierProxyProvider<AuthService, CampaignsService>(
        create: (context) => CampaignsService(
          context.read<AuthService>(),
        ),
        update: (context, authService, sheetService) {
          if (sheetService == null) return CampaignsService(authService);
          sheetService.authService = authService;

          return sheetService;
        },
        child: StreamProvider<List<Campaign>>(
          initialData: const [],
          create: (context) => context.read<CampaignsService>().streamAll(),
          builder: (context, _) {
            final campaigns = context.watch<List<Campaign>>();

            if (campaigns.isEmpty) {
              return const Empty('Você não criou ou entrou em nenhuma campanha.');
            }

            return ListView.builder(
              itemCount: campaigns.length,
              padding: const EdgeInsets.all(5),
              itemBuilder: (context, index) {
                final campaign = campaigns[index];

                return StreamBuilder(
                  initialData: null,
                  stream: User.collection.doc(campaign.ownerUID).snapshots(),
                  builder: (context, snapshot) {
                    if (isSnapshotLoading(snapshot)) return const Loading();

                    final user = snapshot.data!.data()!;

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: Card(
                        child: InkWell(
                          onTap: () => context.pushNamed(RoutesName.campaign.name, pathParameters: {
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
                                      PopupMenuItem(
                                        child: const Text('Excluir'),
                                        onTap: () {
                                          campaign.ref.delete();
                                        },
                                      ),
                                    ];
                                  },
                                ),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: user.avatar,
                                ),
                                title: Text(
                                  campaign.name,
                                  style: const TextStyle(fontWeight: FontWeight.w600),
                                ),
                                subtitle: RichText(
                                  text: TextSpan(
                                    text: 'Mestrado por ',
                                    style: Theme.of(context).textTheme.labelMedium,
                                    children: [
                                      TextSpan(
                                        text: user.username,
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
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
