import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repege/helpers/is_snapshot_loading.dart';
import 'package:repege/icons/rpg_icons.dart';
import 'package:repege/modules/character/screens/character_screen.dart';
import 'package:repege/modules/sheet/sheet_service.dart';
import 'package:repege/modules/sheets/services/sheet.dart';
import 'package:repege/modules/sheets/services/sheets_service.dart';
import 'package:repege/modules/status/screens/status_screen.dart';
import 'package:repege/screens/loading_page.dart';

class SheetScreen extends StatefulWidget {
  const SheetScreen(this.sheetId, {super.key});
  final String sheetId;

  @override
  State<SheetScreen> createState() => _SheetScreenState();
}

class _SheetScreenState extends State<SheetScreen> {
  late Future<Sheet> _sheet;

  @override
  void initState() {
    super.initState();
    _sheet = context.read<SheetsService>().get(widget.sheetId).then((value) => value.data()!);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: FutureBuilder(
          future: _sheet,
          builder: (context, snapshot) {
            if (isSnapshotLoading(snapshot)) {
              return const LoadingPage();
            }

            final sheet = snapshot.data!;

            return ChangeNotifierProvider<SheetService>(
              create: (context) => SheetService(sheet),
              builder: (context, _) {
                return Scaffold(
                  appBar: AppBar(
                    title: Consumer<SheetService>(
                      builder: (context, service, _) {
                        return Text(service.sheet.character.characterName);
                      },
                    ),
                    bottom: const TabBar(
                      labelPadding: EdgeInsets.symmetric(horizontal: 35.0),
                      isScrollable: true,
                      tabs: [
                        Tab(icon: Icon(Rpg.player)),
                        Tab(icon: Icon(Rpg.health)),
                        // Tab(icon: Icon(Rpg.axe)),
                        // Tab(icon: Icon(Rpg.book)),
                      ],
                    ),
                  ),
                  body: Consumer<SheetService>(
                    builder: (context, service, child) {
                      return const TabBarView(
                        children: [
                          CharacterScreen(),
                          StatusScreen(),
                        ],
                      );
                    },
                  ),
                );
              },
            );
          }),
    );
  }
}
