import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/components/loading.dart';
import 'package:repege/modules/sheets/services/sheet_service.dart';
import 'package:repege/modules/user/components/custom_drawer.dart';
import 'package:repege/config/routes_name.dart';
import 'package:repege/helpers/is_snapshot_loading.dart';
import 'package:repege/modules/sheets/components/character_list_item.dart';

class SheetsHomeScreen extends StatelessWidget {
  const SheetsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personagens'),
        actions: [
          IconButton(
            onPressed: () => context.pushNamed(RoutesName.sheetCreate.name),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: CustomDrawer(),
      body: Consumer<SheetService>(
        builder: (context, sheetService, _) {
          return StreamBuilder(
            stream: sheetService.streamAll(),
            initialData: const [],
            builder: (context, snapshot) {
              if (isSnapshotLoading(snapshot)) {
                return const Center(
                  child: Loading(),
                );
              }

              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }

              final sheets = snapshot.data!;

              if (sheets.isEmpty) {
                return const Text(
                  'Não há nenhum personagem. Que tal adicionar algum?',
                );
              }

              return ListView.builder(
                itemCount: sheets.length,
                itemBuilder: (context, index) {
                  return CharacterListItem(sheets[index]);
                },
              );
            },
          );
        },
      ),
    );
  }
}
