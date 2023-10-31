import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/core/widgets/full_screen_scroll.dart';
import 'package:repege/src/sheets/data/models/skills_model.dart';

const ptBRSkills = [
  'Atletismo',
  'Prestidigitação',
  'Furtividade',
  'Acrobacia',
  'Arcano',
  'História',
  'Investigação',
  'Natureza',
  'Religião',
  'Intuição',
  'Trato com animais',
  'Medicina',
  'Percepção',
  'Sobrevivência',
  'Atuação',
  'Persuasão',
  'Intimidação',
  'Enganação',
];

const ptBRSkillsMap = {
  'Atletismo': 'atletism',
  'Prestidigitação': 'sleightOfHand',
  'Furtividade': 'stealth',
  'Acrobacia': 'acrobatics',
  'Arcano': 'arcana',
  'História': 'history',
  'Investigação': 'investigation',
  'Natureza': 'nature',
  'Religião': 'religion',
  'Intuição': 'insight',
  'Trato com animais': 'animalHandling',
  'Medicina': 'medicine',
  'Percepção': 'perception',
  'Sobrevivência': 'survival',
  'Atuação': 'performance',
  'Persuasão': 'persuasion',
  'Intimidação': 'intimidation',
  'Enganação': 'deception',
};

class SkillFloatingList extends StatefulWidget {
  const SkillFloatingList({required this.skills, super.key});
  final SkillsModel skills;
  @override
  State<SkillFloatingList> createState() => _SkillFloatingList();
}

class _SkillFloatingList extends State<SkillFloatingList> {
  SkillsModel skills = SkillsModel.empty();

  void _handleSubmit() {
    context.pop(skills);
  }

  @override
  void initState() {
    super.initState();
    skills = widget.skills;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: FullScreenScroll(
        child: Column(children: [
          AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Perícias'),
            actions: [
              IconButton(
                onPressed: _handleSubmit,
                icon: const Icon(Icons.save),
              )
            ],
          ),
          ...ptBRSkills.map((ptSkill) {
            final skillKey = ptBRSkillsMap[ptSkill]!;
            final value = skills.toMap()[skillKey];

            return CheckboxMenuButton(
              value: value,
              onChanged: (value) {
                setState(() {
                  skills = skills.copyWithMap({skillKey: value ?? false});
                });
              },
              child: Text(ptSkill),
            );
          }),
        ]),
      ),
    );
  }
}
