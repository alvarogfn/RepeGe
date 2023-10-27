import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repege/core/icons/rpg_icons.dart';
import 'package:repege/core/services/injection_container.dart';
import 'package:repege/src/sheets/data/models/sheet_model.dart';
import 'package:repege/src/sheets/domain/bloc/sheet_bloc.dart';
import 'package:repege/src/sheets/domain/cubit/sheet_update_cubit.dart';
import 'package:repege/src/sheets/domain/entities/sheet.dart';
import 'package:repege/src/sheets/presentation/widgets/character_page.dart';
import 'package:repege/src/sheets/presentation/widgets/equipments_page.dart';
import 'package:repege/src/sheets/presentation/widgets/show_text_snackbar.dart';
import 'package:repege/src/sheets/presentation/widgets/spells_page.dart';
import 'package:repege/src/sheets/presentation/widgets/status_page.dart';

class SheetScreen extends StatelessWidget {
  const SheetScreen(this.sheetId, {super.key});
  final String sheetId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final sheetBloc = sl<SheetBloc>();
            sheetBloc.add(SheetInitEvent(sheetId));
            return sheetBloc;
          },
        ),
        BlocProvider(
          create: (context) => sl<SheetUpdateCubit>(),
        ),
      ],
      child: BlocBuilder<SheetBloc, SheetState>(
        builder: (context, state) {
          switch (state) {
            case SheetLoaded<Sheet>():
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
                  body: BlocListener<SheetUpdateCubit, SheetUpdateState>(
                    listener: (context, state) {
                      switch (state) {
                        case SheetUpdateSucess():
                          showTextSnackbar(context, 'Atualizado com sucesso');
                        case SheetUpdateError():
                          showTextSnackbar(context, 'Não foi possível atualizar o campo.');
                        default:
                      }
                    },
                    child: TabBarView(
                      children: [
                        CharacterPage(sheet as SheetModel),
                        StatusPage(sheet),
                        EquipmentsPage(sheet),
                        SpellsPage(sheet),
                      ],
                    ),
                  ),
                ),
              );
            case SheetError():
              return const Text('paia');
            case SheetLoading():
              return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
        },
      ),
    );
  }
}
