import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repege/components/full_screen_scroll.dart';
import 'package:repege/modules/sheets/models/status.dart';
import 'package:repege/modules/sheets/services/sheet.dart';
import 'package:repege/modules/sheets/services/sheet_service.dart';
import 'package:repege/modules/status/components/attributes_card.dart';
import 'package:repege/modules/status/components/life_tracker.dart';
import 'package:repege/modules/status/services/status_service.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen(this.sheet, {super.key});

  final Sheet sheet;

  Status get status => sheet.status;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StatusService(sheetService: context.read<SheetService>(), sheet: sheet),
      builder: (context, child) {
        final statusService = context.read<StatusService>();

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Status'),
          ),
          body: FullScreenScroll(
            child: Column(
              children: [
                LifeTracker(
                  maxHp: status.maxHp,
                  currentHp: status.currentHp,
                  temporaryHp: status.temporaryHp,
                  onChangeMaxHp: (newMaxHp) {
                    statusService.updateOne(context, 'maxHp', newMaxHp);
                  },
                  onChangeTemporaryHp: (newTemporaryHp) {
                    statusService.updateOne(context, 'temporaryHp', newTemporaryHp);
                  },
                  onChangeCurrentHp: (newCurrentHp) {
                    statusService.updateOne(context, 'currentHp', newCurrentHp);
                  },
                ),
                AttributesCard()
              ],
            ),
          ),
        );
      },
    );
  }
}
