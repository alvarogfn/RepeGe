import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/components/custom_drawer.dart';
import 'package:repege/components/loading.dart';
import 'package:repege/components/stream_auth_builder.dart';
import 'package:repege/config/routes_name.dart';
import 'package:repege/helpers/is_snapshot_loading.dart';

class TableHomeScreen extends StatelessWidget {
  const TableHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamAuthBuilder(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () => context.pushNamed(RoutesName.tablesCreate.name),
              icon: const Icon(Icons.add),
            )
          ],
        ),
        drawer: const CustomDrawer(),
        body: StreamBuilder(
          initialData: const ['a', 'b', 'c'],
          builder: (context, snapshot) {
            if (isSnapshotLoading(snapshot)) {
              return const Loading();
            }

            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }

            final tables = snapshot.data!;

            return ListView.builder(
              itemCount: tables.length,
              padding: const EdgeInsets.all(5),
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ListTile(
                          trailing: PopupMenuButton(
                            itemBuilder: (context) {
                              return [
                                const PopupMenuItem(child: Text('Detalhes')),
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
                );
              },
            );
          },
        ),
      ),
    );
  }
}
