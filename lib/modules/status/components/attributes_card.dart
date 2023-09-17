import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repege/helpers/show_keyboard_bottom_sheet.dart';
import 'package:repege/modules/sheet/sheet_service.dart';
import 'package:repege/modules/status/components/skill_floating_list.dart';
import 'package:repege/modules/status/components/text_form_field_bottom_sheet.dart';
import 'package:repege/modules/status/models/attributes.dart';

class AttributesCard extends StatefulWidget {
  const AttributesCard({super.key});

  @override
  State<AttributesCard> createState() => _AttributesCardState();
}

class _AttributesCardState extends State<AttributesCard> {
  Attributes attributes = Attributes();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final sheet = context.read<SheetService>().sheet;
    attributes = sheet.attributes;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Atributos',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Consumer<SheetService>(
                  builder: (context, sheetService, _) => GestureDetector(
                    onTap: () => showKeyboardBottomSheet(
                      context,
                      padding: const EdgeInsets.only(top: 10),
                      builder: (context) {
                        return SkillFloatingList(
                          attributes: attributes,
                          onChanged: (path, newValue) => sheetService.bulkUpdate({path: newValue}),
                        );
                      },
                    ),
                    child: const Icon(Icons.expand),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Consumer<SheetService>(
              builder: (context, service, child) {
                return SizedBox(
                  height: 100,
                  child: GridView(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 20,
                      mainAxisExtent: 40,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      TextFormFieldBottomSheet(
                        label: 'Força',
                        value: attributes.strength.value.toString(),
                        onChanged: (value) => attributes.strength.value = int.tryParse(value) ?? 0,
                        onFieldSubmitted: (_) => service.update(attributes),
                      ),
                      TextFormFieldBottomSheet(
                        label: 'Constituição',
                        value: attributes.constitution.value.toString(),
                        onChanged: (value) => attributes.constitution.value = int.tryParse(value) ?? 0,
                        onFieldSubmitted: (_) => service.update(attributes),
                      ),
                      TextFormFieldBottomSheet(
                        label: 'Destreza',
                        value: attributes.dextery.value.toString(),
                        onChanged: (value) => attributes.dextery.value = int.tryParse(value) ?? 0,
                        onFieldSubmitted: (_) => service.update(attributes),
                      ),
                      TextFormFieldBottomSheet(
                        label: 'Inteligência',
                        value: attributes.intelligence.value.toString(),
                        onChanged: (value) => attributes.intelligence.value = int.tryParse(value) ?? 0,
                        onFieldSubmitted: (_) => service.update(attributes),
                      ),
                      TextFormFieldBottomSheet(
                        label: 'Sabedoria',
                        value: attributes.wisdom.value.toString(),
                        onChanged: (value) => attributes.wisdom.value = int.tryParse(value) ?? 0,
                        onFieldSubmitted: (_) => service.update(attributes),
                      ),
                      TextFormFieldBottomSheet(
                        label: 'Carisma',
                        value: attributes.charisma.value.toString(),
                        onChanged: (value) => attributes.charisma.value = int.tryParse(value) ?? 0,
                        onFieldSubmitted: (_) => service.update(attributes),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
