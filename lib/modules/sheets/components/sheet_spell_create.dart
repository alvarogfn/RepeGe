import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/components/full_screen_scroll.dart';
import 'package:repege/models/dnd/spell.dart';
import 'package:repege/models/extensions.dart';
import 'package:repege/models/utils/utils.dart';
import 'package:repege/modules/sheets/components/checkbox_form_field.dart';
import 'package:repege/modules/spells/services/spells_service.dart';
import 'package:repege/modules/shared/utils/validations/required_validation.dart';

class SheetSpellCreate extends StatefulWidget {
  const SheetSpellCreate({required this.sheetID, this.spell, super.key});

  final Spell? spell;
  final String sheetID;

  @override
  State<SheetSpellCreate> createState() => _SheetSpellCreateState();
}

class _SheetSpellCreateState extends State<SheetSpellCreate> {
  late final SpellModel _model = SpellModel(
    id: widget.spell?.id ?? '',
    name: widget.spell?.name ?? '',
    description: widget.spell?.description ?? '',
    castingTime: widget.spell?.castingTime ?? '',
    catalyts: widget.spell?.catalyts ?? [],
    duration: widget.spell?.duration ?? '',
    effectType: widget.spell?.effectType ?? '',
    level: widget.spell?.level ?? 0,
    materials: widget.spell?.materials ?? '',
    range: widget.spell?.range ?? '',
    type: widget.spell?.type ?? '',
  );

  bool get edit => widget.spell != null;

  List<String> get types {
    return SpellTypes.values.map((e) => e.name.toLowerCase()).toList();
  }

  List<String> get levels {
    return SpellLevels.values.map((e) => e.value.toString()).toList();
  }

  Map<String, String> get catalytics {
    return Map.fromEntries(
      SpellCatalyts.values
          .map((e) => MapEntry(e.name, e.abbreviation))
          .toList(),
    );
  }

  bool isFormValid() {
    final formState = _formKey.currentState;
    if (formState == null) return false;
    return formState.validate();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SpellService>(
      create: (context) => SpellService(sheetID: widget.sheetID),
      builder: (context, child) {
        return Scaffold(
            appBar: AppBar(
              title: Text(edit ? 'Editar' : 'Criar'),
              actions: [
                Consumer<SpellService>(
                  builder: (context, service, child) {
                    return IconButton(
                      onPressed: () async {
                        if (!isFormValid()) return;

                        final doc = await service.addSpell(_model);

                        if (doc.exists && context.mounted) {
                          return context.pop();
                        }

                        if (context.mounted) {
                          await showDialog(
                            context: context,
                            builder: (context) => const AlertDialog(
                              title: Text(
                                'Não foi possível realizar esta ação, tente novamente.',
                              ),
                            ),
                          );
                        }
                      },
                      icon: child!,
                    );
                  },
                  child: const Icon(Icons.save),
                )
              ],
            ),
            body: FullScreenScroll(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  child: Column(
                    children: [
                      input(
                        label: 'Nome',
                        initialValue: _model.name.toCapitalize(),
                        onChanged: (value) => _model.name = value ?? '',
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        action: TextInputAction.next,
                        validations: [RequiredValidation()],
                      ),
                      input(
                        label: 'Descrição',
                        placeholder: 'O que a magia faz?',
                        initialValue: _model.description,
                        onChanged: (value) => _model.description = value ?? '',
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        maxLines: 10,
                        action: TextInputAction.next,
                        validations: [RequiredValidation()],
                      ),
                      input(
                        label: 'Materiais',
                        placeholder:
                            'Algum item ou ritual que é necessário para fazer a magia.',
                        initialValue: _model.materials,
                        maxLines: 2,
                        onChanged: (value) => _model.materials = value ?? '',
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        action: TextInputAction.next,
                      ),
                      select<String>(
                        items: levels,
                        label: 'Nível',
                        initialValue: _model.level.toString(),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        onChanged: (value) {
                          _model.level = int.parse(value ?? '0');
                        },
                      ),
                      input(
                        label: 'Tempo de Conjuração',
                        placeholder: '1 ação',
                        initialValue: _model.castingTime,
                        onChanged: (value) => _model.castingTime = value ?? '',
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        action: TextInputAction.next,
                      ),
                      input(
                        label: 'Alcance',
                        placeholder: '${Random().nextInt(10)} metros',
                        initialValue: _model.range,
                        onChanged: (value) => _model.range = value ?? '',
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        action: TextInputAction.next,
                      ),
                      select(
                        items: types,
                        label: 'Escola da magia:',
                        initialValue:
                            _model.type.isNotEmpty ? _model.type : null,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        onChanged: (value) => _model.type = value ?? '',
                      ),
                      CheckboxFormField(
                        label: 'Catalizadores',
                        options: catalytics,
                        initialValues: _model.catalyts,
                        onChanged: (values) => _model.catalyts = values,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                      ),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }

  Widget input({
    required String label,
    String? placeholder,
    required String initialValue,
    dynamic onChanged,
    dynamic margin,
    dynamic action,
    dynamic maxLines,
    dynamic validations,
  }) {
    return TextFormField();
  }

  Widget select<T>({
    required List<T> items,
    required String label,
    String? initialValue,
    required EdgeInsets margin,
    Function(String)? onChanged,
  }) {
    return TextFormField();
  }
}
