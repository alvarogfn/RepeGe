import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/modules/auth/services/auth_service.dart';
import 'package:repege/modules/campaign/model/campaign.dart';
import 'package:repege/modules/campaigns/service/campaigns_service.dart';
import 'package:repege/modules/user/components/custom_drawer.dart';
import 'package:repege/config/routes_name.dart';

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
      drawer: const CustomDrawer(),
      body: ChangeNotifierProxyProvider<AuthService, CampaignsService>(
        create: (context) => CampaignsService(
          context.read<AuthService>().user!,
        ),
        update: (context, authService, sheetService) {
          final user = context.read<AuthService>().user!;

          if (sheetService == null) return CampaignsService(user);
          sheetService.user = user;

          return sheetService;
        },
        child: StreamProvider<List<Campaign>>(
          initialData: const [],
          create: (context) => context.read<CampaignsService>().streamAll(),
          builder: (context, _) {
            final campaigns = context.watch<List<Campaign>>();

            return ListView.builder(
              itemCount: campaigns.length,
              padding: const EdgeInsets.all(5),
              itemBuilder: (context, index) {
                final campaign = campaigns[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Card(
                    child: InkWell(
                      onTap: () => context.pushNamed(RoutesName.campaign.name, pathParameters: {'id': campaign.id}),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ListTile(
                            trailing: PopupMenuButton(
                              itemBuilder: (context) {
                                return [
                                  const PopupMenuItem(child: Text('Excluir')),
                                ];
                              },
                            ),
                            leading: const CircleAvatar(
                              backgroundColor: Colors.black,
                              backgroundImage: AssetImage(
                                'assets/images/default_profile_picture.png',
                              ),
                            ),
                            title: const Text(
                              'Bastardos em Glórios',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            subtitle: const Text('Mestre Fernando'),
                          ),
                          Image.asset(
                            'assets/images/default_avatar.jpg',
                            width: double.infinity,
                            fit: BoxFit.cover,
                            height: 200,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Magna irure labore tempor do labore minim ad esse proident anim fugiat ad proident. Duis officia elit consectetur proident incididunt aute. Minim pariatur adipisicing dolor duis cupidatat labore id dolore ut sunt esse labore tempor consectetur. Culpa mollit Lorem sunt laboris incididunt Lorem anim. Occaecat occaecat ad irure sint excepteur officia ut ipsum officia qui elit non mollit. Elit voluptate esse nulla eu quis deserunt adipisicing adipisicing occaecat est. Veniam dolore proident commodo anim in sint commodo mollit cillum amet duis in minim excepteur. Minim velit reprehenderit laborum ipsum. Veniam est et est deserunt in minim cillum quis. Officia sit minim ullamco nulla consequat.',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
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
        ),
      ),
    );
  }
}
