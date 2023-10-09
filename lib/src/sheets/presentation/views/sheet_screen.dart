import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repege/_older/icons/rpg_icons.dart';
import 'package:repege/core/services/injection_container.dart';
import 'package:repege/src/sheets/domain/usecase/stream_sheet.dart';
import 'package:repege/src/sheets/presentation/cubit/sheet_cubit.dart';
import 'package:repege/src/sheets/presentation/widgets/casting_page.dart';
import 'package:repege/src/sheets/presentation/widgets/character_page.dart';
import 'package:repege/src/sheets/presentation/widgets/equipment_page.dart';
import 'package:repege/src/sheets/presentation/widgets/status_page.dart';

class SheetScreen extends StatelessWidget {
  const SheetScreen(this.sheetId, {super.key});
  final String sheetId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SheetCubit>(),
      child: _SheetScreen(sheetId),
    );
  }
}

class _SheetScreen extends StatefulWidget {
  const _SheetScreen(this.sheetId);
  final String sheetId;

  @override
  State<_SheetScreen> createState() => __SheetScreenState();
}

class __SheetScreenState extends State<_SheetScreen> {
  StreamSubscription? subscription;

  @override
  void initState() {
    super.initState();
    final sheetsCubit = context.read<SheetCubit>();

    subscription = sheetsCubit.streamSheet(StreamSheetParams(sheetId: widget.sheetId));
  }

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SheetCubit, SheetState>(
      builder: (context, state) {
        switch (state) {
          case SheetLoading():
            return const Dialog.fullscreen(child: Center(child: CircularProgressIndicator()));
          case SheetLoaded():
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
          default:
            return const SizedBox();
        }
      },
    );
  }
}
