import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/components/atoms/label.dart';
import 'package:repege/components/layout/refresh_list_view.dart';
import 'package:repege/components/layout/stream_list_view.dart';
import 'package:repege/components/organism/sheet_list_card.dart';
import 'package:repege/components/organism/custom_drawer.dart';
import 'package:repege/config/route.dart';
import 'package:repege/icons/rpg_icons.dart';
import 'package:repege/models/dnd/sheets/sheet.dart';
import 'package:repege/services/auth_service.dart';

class SheetsPage extends StatelessWidget {
  const SheetsPage({super.key});

  Stream<List<Sheet>> _getSheets(BuildContext context) {
    final user = context.read<AuthService>().user!;
    return user.streamSheets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: newSheetButton(context),
      appBar: AppBar(
        title: const Text("Fichas Cadastradas"),
      ),
      drawer: const CustomDrawer(),
      body: StreamListView(
        stream: _getSheets(context),
        error: errorWidget(),
        empty: const Center(child: Text('Você não tem fichas criadas.')),
        builder: (context, sheet) {
          return SheetListCard(sheet: sheet);
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

        if (sheet == null) return;

        if (context.mounted) {
          final user = context.read<AuthService>().user!;
          final sheetReference = await user.createSheet(sheet);

          if (context.mounted) {
            context.pushNamed(
              RoutesName.sheet.name,
              pathParameters: {'id': sheetReference.id},
            );
          }
        }
      },
      child: const Icon(Icons.add),
    );
  }
}
