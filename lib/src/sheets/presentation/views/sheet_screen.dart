import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repege/_older/icons/rpg_icons.dart';
import 'package:repege/core/services/injection_container.dart';
import 'package:repege/src/sheets/data/models/sheet_model.dart';
import 'package:repege/src/sheets/domain/bloc/sheet_bloc.dart';
import 'package:repege/src/sheets/domain/cubit/sheet_update_cubit.dart' as cubit;
import 'package:repege/src/sheets/presentation/widgets/casting_page.dart';
import 'package:repege/src/sheets/presentation/widgets/character_page.dart';
import 'package:repege/src/sheets/presentation/widgets/equipment_page.dart';
import 'package:repege/src/sheets/presentation/widgets/show_text_snackbar.dart';
import 'package:repege/src/sheets/presentation/widgets/status_page.dart';

class SheetScreen extends StatelessWidget {
  const SheetScreen(this.sheetId, {super.key});
  final String sheetId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SheetBloc, SheetState>(
      builder: (context, state) {
        switch (state) {
          case SheetLoaded<SheetModel>():
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
                body: BlocProvider(
                  create: (context) => sl<cubit.SheetUpdateCubit>(),
                  child: BlocListener<cubit.SheetUpdateCubit, cubit.SheetUpdateState>(
                    listener: (context, state) {
                      switch (state) {
                        case cubit.SheetUpdateSucess():
                          showTextSnackbar(context, 'Atualizado com sucesso');
                        case cubit.SheetUpdateError():
                          showTextSnackbar(context, 'Não foi possível atualizar o campo.');
                        default:
                      }
                    },
                    child: TabBarView(
                      children: [
                        CharacterPage(sheet),
                        StatusPage(sheet),
                        EquipmentPage(sheet),
                        CastingPage(sheet),
                      ],
                    ),
                  ),
                ),
              ),
            );
          default:
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
