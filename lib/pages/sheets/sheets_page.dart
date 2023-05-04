import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/components/base/label.dart';
import 'package:repege/components/layout/refresh_list_view.dart';
import 'package:repege/components/shared/custom_drawer.dart';
import 'package:repege/components/shared/loading.dart';
import 'package:repege/config/route.dart';
import 'package:repege/icons/octicons_icons.dart';
import 'package:repege/icons/rpg_icons.dart';
import 'package:repege/models/dnd/sheets/sheet.dart';
import 'package:repege/services/auth_service.dart';

class SheetsPage extends StatelessWidget {
  const SheetsPage({super.key});

  Future<List<Sheet>> _getSheets(BuildContext context) {
    final user = context.read<AuthService>().user!;
    return Future.error(">:(");
    return user.sheets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: newSheetButton(context),
      appBar: AppBar(
        title: const Text("Fichas Cadastradas"),
      ),
      drawer: const CustomDrawer(),
      body: RefreshListView(
        future: _getSheets,
        error: errorWidget(),
        empty: const Center(child: Text('Você não tem fichas criadas.')),
        builder: (context, value) {
          return Text(value.characterName);
        },
      ),
    );
  }

  Center errorWidget() {
    return const Center(
      child: Label(
        color: Colors.black87,
        text: 'Alguma coisa deu errado',
        icon: Rpg.burning_book,
        width: 220,
      ),
    );
  }

  FloatingActionButton newSheetButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        Sheet? sheet = await context.pushNamed<Sheet?>(
          RoutesName.sheetCreate.name,
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
