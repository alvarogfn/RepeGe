import 'package:flutter/material.dart';
import 'package:repege/components/full_screen_scroll.dart';
import 'package:repege/modules/status/models/attributes.dart';

class SkillFloatingList extends StatelessWidget {
  const SkillFloatingList({required this.attributes, required this.onChanged, super.key});

  final Attributes attributes;

  final void Function(String property, bool newValue) onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: FullScreenScroll(
        child: Column(
          children: [
            generateSkillList(attributes.strength, title: 'Força', translationMap: {
              'atletism': 'Atletismo',
            }),
            generateSkillList(attributes.constitution, title: 'Constituição', translationMap: {
              'atletism': 'Atletismo',
            }),
            generateSkillList(attributes.dextery, title: 'Destreza', translationMap: {
              'atletism': 'Atletismo',
            }),
            generateSkillList(attributes.dextery, title: 'Destreza', translationMap: {
              'atletism': 'Atletismo',
            }),
            generateSkillList(attributes.intelligence, title: 'Inteligência', translationMap: {
              'atletism': 'Atletismo',
            }),
            generateSkillList(attributes.wisdom, title: 'Sabedoria', translationMap: {
              'atletism': 'Atletismo',
            }),
            generateSkillList(attributes.charisma, title: 'Carisma', translationMap: {
              'atletism': 'Atletismo',
            }),
          ],
        ),
      ),
    );
  }

  Widget attributeTypeTitle(String title) {
    return Builder(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Text(title, style: Theme.of(context).textTheme.titleLarge),
        );
      },
    );
  }

  Widget generateSkillList(Attribute attribute, {required String title, required Map<String, String> translationMap}) {
    final attributeMap = attribute.toMap();
    final attributeMapCopy = Map.from(attributeMap);

    attributeMapCopy.remove('value');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        attributeTypeTitle(title),
        ...attributeMapCopy.entries.map((entry) {
          final skill = translationMap[entry.key] ?? entry.key;
          return Column(
            children: [
              CheckboxMenuButton(
                value: entry.value,
                onChanged: (newValue) {
                  //
                  onChanged('${attributes.propertyKey}.${attribute.propertyKey}.${entry.key}', newValue ?? false);
                },
                child: Text(skill),
              )
            ],
          );
        })
      ],
    );
  }
}
