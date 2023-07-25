import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repege/helpers/is_snapshot_loading.dart';
import 'package:repege/modules/authentication/services/auth_service.dart';
import 'package:repege/modules/sheets/modules/sheet/screens/sheet_character_details_page.dart';
import 'package:repege/modules/sheets/modules/sheet/screens/sheet_spells_details_page.dart';
import 'package:repege/modules/sheets/modules/sheet/screens/sheet_status_details_page.dart';
import 'package:repege/icons/rpg_icons.dart';
import 'package:repege/models/dnd/sheets/sheet.dart';
import 'package:repege/screens/loading_page.dart';
import 'package:repege/modules/sheets/services/sheets_service.dart';

class SheetPage extends StatefulWidget {
  const SheetPage({required this.id, super.key});
  final String id;

  @override
  State<SheetPage> createState() => _SheetHomePageState();
}

class _SheetHomePageState extends State<SheetPage> {
  List<Widget> pages(DocumentSnapshot<Sheet?> sheet) => [
        SheetCharacterDetailsPage(sheet),
        SheetStatusDetailsPage(sheet),
        const Text('Inventário'),
        SheetSpellsDetailsPage(sheet),
      ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<AuthService, SheetsService>(
      create: (context) {
        final user = context.read<AuthService>().user!;
        return SheetsService(user: user);
      },
      update: (context, value, _) => SheetsService(user: value.user!),
      builder: (context, _) {
        return DefaultTabController(
          length: 4,
          child: Consumer<SheetsService>(
            builder: (context, service, _) {
              return StreamBuilder(
                stream: service.getSheetRef(widget.id).snapshots(),
                builder: (context, snap) {
                  if (isSnapshotLoading(snap)) {
                    return const LoadingPage();
                  }

                  if (snap.hasError) {
                    return const Text('Alguma coisa deu errado.');
                  }

                  final sheet = snap.data!.data()!;

                  return Scaffold(
                    appBar: AppBar(
                      title: Text(sheet.characterName),
                      bottom: const TabBar(
                        labelPadding: EdgeInsets.symmetric(horizontal: 35.0),
                        isScrollable: true,
                        tabs: [
                          Tab(icon: Icon(Rpg.player)),
                          Tab(icon: Icon(Rpg.health)),
                          Tab(icon: Icon(Rpg.axe)),
                          Tab(icon: Icon(Rpg.book)),
                        ],
                      ),
                    ),
                    body: TabBarView(
                      children: pages(snap.data!),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
