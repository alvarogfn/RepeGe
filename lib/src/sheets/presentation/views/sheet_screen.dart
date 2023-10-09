import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repege/_older/icons/rpg_icons.dart';
import 'package:repege/core/services/injection_container.dart';
import 'package:repege/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:repege/src/sheets/domain/usecase/stream_all_sheets.dart';
import 'package:repege/src/sheets/presentation/cubit/sheet_cubit.dart';
import 'package:repege/src/sheets/presentation/cubit/sheets_cubit.dart';
import 'package:repege/src/sheets/presentation/widgets/casting_page.dart';
import 'package:repege/src/sheets/presentation/widgets/character_page.dart';
import 'package:repege/src/sheets/presentation/widgets/equipment_page.dart';
import 'package:repege/src/sheets/presentation/widgets/status_page.dart';

class SheetScreen extends StatefulWidget {
  const SheetScreen(this.sheetId, {super.key});
  final String sheetId;

  @override
  State<SheetScreen> createState() => _SheetScreenState();
}

class _SheetScreenState extends State<SheetScreen> {
  StreamSubscription? subscription;

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthenticationCubit>().state;
    final sheetsCubit = context.read<SheetsCubit>();

    if (authState is Authenticated) {
      subscription = sheetsCubit.streamAllSheets(StreamAllSheetsParams(createdBy: authState.user.id));
    }
  }

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SheetCubit>(
      create: (context) => sl<SheetCubit>(),
      child: BlocBuilder<SheetCubit, SheetState>(
        builder: (context, state) {
          if (state is SheetLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is SheetLoaded) {
            final sheet = state.sheet;

            return DefaultTabController(
              length: 4,
              child: Scaffold(
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
                  children: [
                    CharacterPage(sheet),
                    StatusPage(sheet),
                    EquipmentPage(sheet),
                    CastingPage(sheet),
                  ],
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
