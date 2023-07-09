import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repege/modules/shared/components/sheet_service_wrapper.dart';
import 'package:repege/modules/sheet/screens/sheet_character_details_page.dart';
import 'package:repege/modules/sheet/screens/sheet_spells_details_page.dart';
import 'package:repege/modules/sheet/screens/sheet_status_details_page.dart';
import 'package:repege/icons/rpg_icons.dart';
import 'package:repege/models/dnd/sheets/sheet.dart';
import 'package:repege/screens/loading_page.dart';
import 'package:repege/modules/sheet/services/sheet_service.dart';

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
    return SheetServiceWrapper(builder: (context, _) {
      return DefaultTabController(
        length: 4,
        child: Consumer<SheetService>(
          builder: (context, service, _) {
            return StreamBuilder(
              stream: service.getSheetRef(widget.id).snapshots(),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const LoadingPage();
                }

                if (snap.hasError) {
                  return const Text('Alguma coisa deu errado.');
                }

                final sheetDoc = snap.data!;

                return Scaffold(
                  appBar: _AppBar(
                    characterName: sheetDoc.data()!.characterName,
                  ),
                  body: TabBarView(
                    children: pages(sheetDoc),
                  ),
                );
              },
            );
          },
        ),
      );
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
          Tab(icon: Icon(Rpg.player)),
          Tab(icon: Icon(Rpg.health)),
          Tab(icon: Icon(Rpg.axe)),
          Tab(icon: Icon(Rpg.book)),
        ],
      ),
    );
  }
}
