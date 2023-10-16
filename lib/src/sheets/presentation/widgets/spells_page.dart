import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/core/routes/routes_name.dart';
import 'package:repege/core/services/injection_container.dart';
import 'package:repege/core/widgets/card_title.dart';
import 'package:repege/core/widgets/text_form_field_bottom_sheet.dart';
import 'package:repege/src/sheets/data/models/sheet_model.dart';
import 'package:repege/src/sheets/data/models/spell_model.dart';
import 'package:repege/src/sheets/domain/cubit/sheet_update_cubit.dart';
import 'package:repege/src/spells/domain/bloc/spell_bloc.dart';
import 'package:repege/src/spells/presentation/widgets/spell_list_item.dart';

class SpellsPage extends StatelessWidget {
  const SpellsPage(this.sheet, {super.key});

  final SheetModel sheet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Magias'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CardTitle(
            title: 'Atributos',
            child: Builder(builder: (context) {
              final update = context.read<SheetUpdateCubit>().update;

              return GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 20,
                  mainAxisExtent: 50,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  TextFormFieldBottomSheet(
                    label: 'Bonus de Ataque',
                    value: sheet.attackBonus.toString(),
                    onFieldSubmitted: (value) => update(sheet.copyWith(attackBonus: int.tryParse(value) ?? 0)),
                  ),
                  TextFormFieldBottomSheet(
                    label: 'Hab. de Conjuração',
                    value: sheet.castingHability.toString(),
                    onFieldSubmitted: (value) => update(sheet.copyWith(castingHability: int.tryParse(value) ?? 0)),
                  ),
                  TextFormFieldBottomSheet(
                    label: 'Res. Mágica',
                    value: sheet.magicResistance.toString(),
                    onFieldSubmitted: (value) => update(sheet.copyWith(magicResistance: int.tryParse(value) ?? 0)),
                  ),
                ],
              );
            }),
          ),
          BlocProvider(
            create: (context) {
              final bloc = sl<SpellBloc>();
              bloc.add(SpellInitEvent(sheet.id));
              return bloc;
            },
            child: Expanded(
              child: CardTitle(
                title: 'Magias',
                icon: Builder(
                  builder: (context) {
                    return GestureDetector(
                      child: const Icon(Icons.add),
                      onTap: () async {
                        final spell = await context.pushNamed<SpellModel>(Routes.spellsForm.name);

                        if (spell == null) return;

                        if (context.mounted) {
                          context.read<SpellBloc>().add(SpellCreateEvent(spell.copyWith(sheetId: sheet.id)));
                        }
                      },
                    );
                  },
                ),
                child: BlocBuilder<SpellBloc, SpellState>(
                  builder: (context, state) {
                    switch (state) {
                      case SpellStateLoaded():
                        return Expanded(
                          child: ListView.builder(
                            itemCount: state.spells.length,
                            itemBuilder: (context, index) {
                              return SpellListItem(state.spells[index] as SpellModel);
                            },
                          ),
                        );
                      case SpellStateEmpty():
                        return const Text('Nenhuma magia cadastrada.');
                      case SpellStateLoading():
                        return const Center(child: CircularProgressIndicator());
                      case SpellStateError():
                        return Text(state.message);
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
