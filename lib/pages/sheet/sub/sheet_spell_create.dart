import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/components/shared/form/form_builder.dart';
import 'package:repege/components/shared/full_screen_scroll.dart';
import 'package:repege/models/dnd/damage.dart';
import 'package:repege/models/dnd/spell.dart';
import 'package:repege/models/utils/field.dart';

class SheetSpellCreate extends StatefulWidget {
  const SheetSpellCreate({super.key});

  @override
  State<SheetSpellCreate> createState() => _SheetSpellCreateState();
}

class _SheetSpellCreateState extends State<SheetSpellCreate> {
  Map<String, Object?> _formData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Magia'),
        actions: [
          IconButton(
            onPressed: () => context.pop(_formData),
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: FullScreenScroll(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
          child: FormBuilder(
            fields: [
              FieldText(label: "Nome", value: "", propertyKey: "name"),
              FieldText(
                label: "Descrição",
                value: "",
                propertyKey: "description",
                lines: 5,
              ),
              FieldText(
                label: "Tempo de Conjuração",
                value: "",
                propertyKey: "castingTime",
              ),
              FieldSelect(
                label: "Tipo",
                value: "",
                propertyKey: "type",
                options: SpellTypes.values.map((e) => e.name).toList(),
              ),
              FieldSelect(
                label: "Nível",
                value: "",
                propertyKey: "level",
                options: SpellLevels.values.map((e) => e.name).toList(),
              ),
              FieldSelect(
                label: "Dano/Efeito",
                value: "",
                propertyKey: "damageType",
                options: Damage.values.map((e) => e.name).toList()
                  ..add("Outro"),
              ),
              FieldCheckbox(
                label: "Catalizadores",
                propertyKey: 'catalyts',
                options: SpellCatalyts.values.map((e) => e.name).toList(),
                values: [],
              )
            ],
            submitLabel: "Adicionar",
            title: "Informações da Magia",
            onChanged: (values) {
              setState(() => _formData = values);
            },
          ),
        ),
      ),
    );
  }
}
