import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/components/custom_drawer.dart';
import 'package:repege/config/routes_name.dart';
import 'package:repege/helpers/is_snapshot_loading.dart';
import 'package:repege/modules/sheets/components/character_list_item.dart';
import 'package:repege/modules/sheets/services/sheet.dart';

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
      drawer: const CustomDrawer(),
      body: StreamBuilder<List<Sheet>>(
        stream: Sheet.stream(),
        initialData: const [],
        builder: (context, snapshot) {
          if (isSnapshotLoading(snapshot)) {
            return const Text('Carregando');
          }

          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          final sheets = snapshot.data!;

          if (sheets.isEmpty) {
            return const Text('h');
          }

          return ListView.builder(
            itemCount: sheets.length,
            itemBuilder: (context, index) {
              return CharacterListItem(sheets[index]);
            },
          );
        },
      ),
    );
  }
}
