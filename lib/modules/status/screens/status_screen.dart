import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repege/components/full_screen_scroll.dart';
import 'package:repege/modules/sheet/sheet_service.dart';
import 'package:repege/modules/sheets/services/sheet.dart';
import 'package:repege/modules/status/components/attributes_card.dart';
import 'package:repege/modules/status/components/life_tracker.dart';
import 'package:repege/modules/status/models/status.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({super.key});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  Status status = Status();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final sheet = context.read<Sheet>();
    status = sheet.status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Status'),
      ),
      body: FullScreenScroll(
        child: Column(
          children: [
            Consumer<SheetService>(
              builder: (context, sheetService, _) {
                return LifeTracker(
                  maxHp: status.maxHp,
                  currentHp: status.currentHp,
                  temporaryHp: status.temporaryHp,
                  onChangeMaxHp: (newMaxHp) {
                    status.maxHp = newMaxHp;
                    sheetService.update(status);
                  },
                  onChangeTemporaryHp: (newTemporaryHp) {
                    status.temporaryHp = newTemporaryHp;
                    sheetService.update(status);
                  },
                  onChangeCurrentHp: (newCurrentHp) {
                    status.currentHp = newCurrentHp;
                    sheetService.update(status);
                  },
                );
              },
            ),
            const AttributesCard()
          ],
        ),
      ),
    );
  }
}
