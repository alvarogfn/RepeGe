import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repege/core/widgets/card_title.dart';
import 'package:repege/core/widgets/text_form_field_bottom_sheet.dart';
import 'package:repege/core/widgets/full_screen_scroll.dart';
import 'package:repege/src/sheets/data/models/sheet_model.dart';
import 'package:repege/src/sheets/domain/bloc/sheet_bloc.dart';
import 'package:repege/src/sheets/domain/cubit/sheet_update_cubit.dart';
import 'package:repege/src/sheets/presentation/widgets/life_tracker.dart';
import 'package:repege/src/sheets/presentation/widgets/skill_floating_list.dart';
import 'package:repege/src/sheets/presentation/widgets/title_form_field_bottom_sheet.dart';

class StatusPage extends StatelessWidget {
  const StatusPage(this.sheet, {super.key});

  final SheetModel sheet;

  @override
  Widget build(BuildContext context) {
    final update = context.read<SheetUpdateCubit>().update;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Status'),
      ),
      body: FullScreenScroll(
        child: Column(
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
            CardTitle(
              title: 'Atributos',
              icon: GestureDetector(
                child: const Icon(Icons.expand),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) {
                      return MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) => context.read<SheetBloc>(),
                          ),
                          BlocProvider(
                            create: (context) => context.read<SheetUpdateCubit>(),
                          ),
                        ],
                        child: const SkillFloatingList(),
                      );
                    },
                  );
                },
              ),
              child: SizedBox(
                height: 100,
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 20,
                    mainAxisExtent: 36,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: sheet.attributes.toMap().entries.map((attribute) {
                    return AttributeFormFieldBottomSheet(
                      label: attribute.key,
                      value: attribute.value,
                      title: ((attribute.value - 10) ~/ 2).toString(),
                      onFieldSubmitted: (value) => update(sheet.copyWithMap({attribute.key: value})),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
