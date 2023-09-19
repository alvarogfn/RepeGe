import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/components/empty.dart';
import 'package:repege/modules/auth/services/auth_service.dart';
import 'package:repege/modules/sheets/components/character_list_item.dart';
import 'package:repege/modules/sheets/services/sheet.dart';
import 'package:repege/modules/sheets/services/sheets_service.dart';
import 'package:repege/modules/user/components/custom_drawer.dart';
import 'package:repege/config/routes_name.dart';

class SheetsScreen extends StatelessWidget {
  const SheetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personagens'),
        actions: [
          IconButton(
            onPressed: () => context.pushNamed(RoutesName.sheetCreate.name),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: const CustomDrawer(),
      body: ChangeNotifierProxyProvider<AuthService, SheetsService>(
        create: (context) => SheetsService(
          context.read<AuthService>().user!,
        ),
        update: (context, authService, sheetService) {
          final user = context.read<AuthService>().user!;

          if (sheetService == null) return SheetsService(user);
          sheetService.user = user;

          return sheetService;
        },
        child: StreamProvider<List<Sheet>>(
          initialData: const [],
          create: (context) => context.read<SheetsService>().streamAll(),
          builder: (context, child) {
            final sheets = context.watch<List<Sheet>>();

            if (sheets.isEmpty) {
              return const Empty('Nenhum personagem criado.');
            }

            return ListView.builder(
              itemCount: sheets.length,
              itemBuilder: (context, index) {
                return CharacterListItem(sheets[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
