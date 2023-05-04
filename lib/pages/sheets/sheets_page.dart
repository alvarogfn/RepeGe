import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/components/domains/sheets/dnd_sheet_card.dart';
import 'package:repege/components/domains/sheets/empty_sheet_list.dart';
import 'package:repege/components/shared/custom_drawer.dart';
import 'package:repege/components/shared/loading.dart';
import 'package:repege/models/dnd/sheets/sheet.dart';

import 'package:repege/config/route.dart';
import 'package:repege/services/auth_service.dart';

class SheetsPage extends StatefulWidget {
  const SheetsPage({super.key});

  @override
  State<SheetsPage> createState() => _SheetsPageState();
}

class _SheetsPageState extends State<SheetsPage> {
  Future<List<Sheet>>? futureSheets;

  Future<void> _refreshSheets() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    setState(() {
      futureSheets = authService.user?.sheets() ?? Future.value([]);
    });
  }

  @override
  void didUpdateWidget(covariant SheetsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    _refreshSheets();
  }

  @override
  void initState() {
    super.initState();
    _refreshSheets();
  }

  Future<void> _deleteSheet(Sheet sheet) async {
    String message = '';

    try {
      await sheet.delete();
      message = 'A ficha de ${sheet.characterName} foi deletada com sucesso.';
    } catch (e) {
      message = 'Não foi possível deletar a ficha de ${sheet.characterName}.';
    }

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
      ));
    }
    _refreshSheets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const CustomDrawer(),
      body: FutureBuilder<List<Sheet>>(
        future: futureSheets,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          }

          if (snapshot.data != null && snapshot.data!.isEmpty) {
            return RefreshIndicator(
              onRefresh: _refreshSheets,
              child: ListView(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: EmptySheetList(),
                  )
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _refreshSheets,
            child: ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                return SheetCard(
                  sheet: snapshot.data![index],
                  deleteSheet: _deleteSheet,
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(RoutesName.sheetCreate.name);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
