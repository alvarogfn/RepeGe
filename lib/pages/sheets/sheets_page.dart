import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/components/domains/sheets/dnd_sheet_card.dart';
import 'package:repege/components/domains/sheets/empty_sheet_list.dart';
import 'package:repege/components/shared/custom_drawer.dart';
import 'package:repege/components/shared/handlers/error_handler.dart';
import 'package:repege/components/shared/loading.dart';
import 'package:repege/database/sheets_db.dart';
import 'package:repege/models/dnd/sheets/dnd_sheet.dart';

import 'package:repege/route.dart';
import 'package:repege/services/auth_service.dart';

class SheetsPage extends StatelessWidget {
  SheetsPage({super.key});

  final List<DnDSheet> sheets = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const CustomDrawer(),
      body: Consumer<AuthService>(builder: (context, authService, value) {
        return StreamBuilder<QuerySnapshot<DnDSheet?>>(
          stream: SheetsDB.streamOfCreator(authService.currentUser!.uid),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return ErrorHandler(error: snapshot.error as Exception);
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loading();
            }

            if (!snapshot.hasData) {
              return const Center(child: Text("Vazio"));
            }

            final sheets = snapshot.data!.docs
                .map((doc) => DndSheetCard(sheet: doc.data()!))
                .toList();

            if (sheets.isEmpty) {
              return const EmptySheetList();
            }

            return ListView(
              children: sheets,
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(RoutesName.sheetCreate.name);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
