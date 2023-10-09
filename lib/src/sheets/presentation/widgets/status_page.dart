import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repege/core/widgets/card_title.dart';
import 'package:repege/core/widgets/text_form_field_bottom_sheet.dart';
import 'package:repege/core/widgets/full_screen_scroll.dart';
import 'package:repege/src/sheets/data/models/sheet_model.dart';
import 'package:repege/src/sheets/presentation/cubit/sheet_cubit.dart';
import 'package:repege/src/sheets/presentation/widgets/life_tracker.dart';

class StatusPage extends StatelessWidget {
  const StatusPage(this.sheet, {super.key});

  final SheetModel sheet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Status'),
      ),
      body: FullScreenScroll(
        child: Builder(builder: (context) {
          final update = context.read<SheetCubit>().editSheet;

          return Column(
            children: [
              LifeTracker(
                maxHp: sheet.maxHp,
                currentHp: sheet.currentHp,
                temporaryHp: sheet.temporaryHp,
                onChangeMaxHp: (newMaxHp) => update(sheet.copyWith(maxHp: newMaxHp)),
                onChangeTemporaryHp: (newTemporaryHp) => update(sheet.copyWith(temporaryHp: newTemporaryHp)),
                onChangeCurrentHp: (newCurrentHp) => update(sheet.copyWith(currentHp: newCurrentHp)),
              ),
              CardTitle(
                title: 'Combate',
                child: SizedBox(
                  height: 40,
                  child: GridView(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisExtent: 40,
                    ),
                    children: [
                      TextFormFieldBottomSheet(
                        label: 'CA',
                        value: sheet.armorClass.toString(),
                        onFieldSubmitted: (value) => update(sheet.copyWith(armorClass: int.parse(value))),
                      ),
                      TextFormFieldBottomSheet(
                        label: 'Iniciativa',
                        value: sheet.iniative.toString(),
                        onFieldSubmitted: (value) => update(sheet.copyWith(iniative: int.parse(value))),
                      ),
                      TextFormFieldBottomSheet(
                        label: 'Deslocamento',
                        value: sheet.speed.toString(),
                        onFieldSubmitted: (value) => update(sheet.copyWith(speed: int.parse(value))),
                      ),
                    ],
                  ),
                ),
              ),
              // const DeathSavesCard(),
              // const AttributesCard(),
            ],
          );
        }),
      ),
    );
  }
}
