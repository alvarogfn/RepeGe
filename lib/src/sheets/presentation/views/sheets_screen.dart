import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/core/routes/routes_name.dart';
import 'package:repege/src/miscellaneous/presentation/widgets/app_drawer.dart';

class SheetsScreen extends StatelessWidget {
  const SheetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();

    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Personagens'),
    //     actions: [
    //       IconButton(
    //         onPressed: () => context.go(Routes.sheetCreate.name),
    //         icon: const Icon(Icons.add),
    //       )
    //     ],
    //   ),
    //   drawer: const AppDrawer(),
    //   body: ChangeNotifierProxyProvider<AuthService, SheetsService>(
    //     create: (context) => SheetsService(
    //       context.read<AuthService>().user!,
    //     ),
    //     update: (context, authService, sheetService) {
    //       final user = context.read<AuthService>().user!;

    //       if (sheetService == null) return SheetsService(user);
    //       sheetService.user = user;

    //       return sheetService;
    //     },
    //     child: StreamProvider<List<Sheet>>(
    //       initialData: const [],
    //       create: (context) => context.read<SheetsService>().streamAll(),
    //       builder: (context, child) {
    //         final sheets = context.watch<List<Sheet>>();

    //         if (sheets.isEmpty) {
    //           return const Empty('Nenhum personagem criado.');
    //         }

    //         return ListView.builder(
    //           itemCount: sheets.length,
    //           itemBuilder: (context, index) {
    //             return CharacterListItem(sheets[index]);
    //           },
    //         );
    //       },
    //     ),
    //   ),
    // );
  }
}
