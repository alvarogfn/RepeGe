import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/database/sheets_db.dart';
import 'package:repege/models/dnd/sheets/dnd_sheet.dart';
import 'package:repege/pages/sheets/sheet_person_page.dart';
import 'package:repege/pages/utils/loading_page.dart';
import 'package:repege/route.dart';

class SheetPage extends StatefulWidget {
  const SheetPage({required this.id, super.key});
  final String id;

  @override
  State<SheetPage> createState() => _SheetHomePageState();
}

class _SheetHomePageState extends State<SheetPage> {
  Future<void> showErrorDialog(Object e) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Não foi possível buscar essa ficha.'),
        content: Text(e.toString()),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
              context.goNamed(RoutesName.sheets.name);
            },
            child: Text(
              'Voltar',
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          )
        ],
      ),
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<DnDSheet?>>(
        stream: SheetsDB.streamOfSheet(widget.id),
        builder: (context, snapshot) {
          final DnDSheet? sheet = snapshot.data?.data();
          if (sheet != null) {
            return DefaultTabController(
              length: 5,
              child: Scaffold(
                appBar: _AppBar(characterName: sheet.characterName),
                body: TabBarView(
                  children: [
                    SheetPersonPage(sheet),
                    Text('Status'),
                    Text('Inventário'),
                    Text('Itens'),
                    Text('Magias'),
                  ],
                ),
              ),
            );
          }

          if (snapshot.hasError) {
            showErrorDialog(snapshot.error!);
            return const SizedBox();
          }

          return const LoadingPage();
        });
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({required this.characterName});

  @override
  Size get preferredSize {
    return const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);
  }

  final String characterName;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(characterName),
      bottom: const TabBar(
        labelPadding: EdgeInsets.symmetric(horizontal: 35.0),
        isScrollable: true,
        tabs: [
          Tab(icon: Icon(Icons.person)),
          Tab(icon: Icon(Icons.healing)),
          Tab(icon: Icon(Icons.inventory_2)),
          Tab(icon: Icon(Icons.shape_line)),
          Tab(icon: Icon(Icons.book_outlined)),
        ],
      ),
    );
  }
}
