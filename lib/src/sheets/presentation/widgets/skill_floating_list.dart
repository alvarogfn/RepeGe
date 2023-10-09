import 'package:flutter/material.dart';
import 'package:repege/_older/modules/status/models/attributes.dart';
import 'package:repege/core/widgets/full_screen_scroll.dart';


class SkillFloatingList extends StatefulWidget {
  const SkillFloatingList({required this.attributes, required this.onChanged, super.key});

  final Attributes attributes;

  final void Function(String property, bool newValue) onChanged;

  @override
  State<SkillFloatingList> createState() => _SkillFloatingListState();
}

class _SkillFloatingListState extends State<SkillFloatingList> {
  Map<String, dynamic> _data = {};

  @override
  void initState() {
    super.initState();
    _data = widget.attributes.toMap();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _data = widget.attributes.toMap();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: FullScreenScroll(
        child: Column(
          children: [
            generateSkillList('strength', title: 'Força', translationMap: {
              'atletism': 'Atletismo',
            }),
            generateSkillList('constitution', title: 'Constituição', translationMap: {}),
            generateSkillList('dextery', title: 'Destreza', translationMap: {
              'sleightOfHand': 'Prestidigitação',
              'stealth': 'Furtividade',
              'acrobatics': 'Acrobacia',
            }),
            generateSkillList('intelligence', title: 'Inteligência', translationMap: {
              'arcana': 'Arcanismo',
              'history': 'História',
              'investigation': 'Investigação',
              'nature': 'Natureza',
              'religion': 'Religião'
            }),
            generateSkillList('wisdom', title: 'Sabedoria', translationMap: {
              'insight': 'Intuição',
              'medicine': 'Medicina',
              'perception': 'Percepção',
              'survival': 'Sobrevivência'
            }),
            generateSkillList('charisma', title: 'Carisma', translationMap: {
              'performance': 'Performance',
              'persuasion': 'Persuasão',
              'intimidation': 'Intimidação',
              'deception': 'Enganação',
            }),
          ],
        ),
      ),
    );
  }

  Widget generateSkillList(
    String key, {
    required String title,
    required Map<String, String> translationMap,
  }) {
    final attributeMapCopy = Map.from(_data[key]!);

    attributeMapCopy.remove('value');

    if (attributeMapCopy.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(title, style: Theme.of(context).textTheme.titleLarge),
            );
          },
        ),
        ...attributeMapCopy.entries.map((entry) {
          final skill = translationMap[entry.key] ?? entry.key;
          return Column(
            children: [
              CheckboxMenuButton(
                value: _data[key]![entry.key],
                onChanged: (newValue) {
                  setState(() {
                    _data[key]![entry.key] = newValue;
                  });

                  widget.onChanged(
                    '${widget.attributes.propertyKey}.$key.${entry.key}',
                    newValue ?? false,
                  );
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
