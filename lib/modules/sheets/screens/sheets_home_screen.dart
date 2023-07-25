import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repege/helpers/is_snapshot_loading.dart';
import 'package:repege/modules/authentication/services/auth_service.dart';
import 'package:repege/modules/home/components/custom_drawer.dart';
import 'package:repege/modules/sheets/components/sheets_character_card.dart';
import 'package:repege/modules/sheets/components/sheets_character_create_action_button.dart';
import 'package:repege/modules/sheets/components/sheets_empty_card.dart';
import 'package:repege/modules/sheets/components/sheets_error_indicator.dart';
import 'package:repege/modules/sheets/components/sheets_loading_indicator.dart';
import 'package:repege/modules/sheets/services/sheets_service.dart';

class SheetsHomePage extends StatelessWidget {
  const SheetsHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<AuthService, SheetsService>(
      create: (context) =>
          SheetsService(user: context.read<AuthService>().user!),
      update: (context, value, _) => SheetsService(user: value.user!),
      child: const CustomDrawer(),
      builder: (context, child) {
        return Scaffold(
          drawer: child,
          appBar: AppBar(title: const Text('Personagens')),
          floatingActionButton: SheetsCharacterCreateActionButton(),
          body: Consumer<SheetsService>(
            builder: (context, service, child) {
              return StreamBuilder(
                stream: service.streamAllSheets(),
                builder: (context, snapshot) {
                  if (isSnapshotLoading(snapshot)) {
                    return SheetsLoadingIndicator();
                  }
                  if (snapshot.hasError) {
                    return SheetsErrorIndicator();
                  }

                  final sheets = snapshot.data!;

                  if (sheets.isEmpty) {
                    return SheetsEmptyCard();
                  }

                  return ListView.builder(
                    itemCount: sheets.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SheetsCharacterCard(sheets[index]),
                      );
                    },
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
