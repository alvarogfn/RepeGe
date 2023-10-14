import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repege/core/widgets/full_screen_scroll.dart';
import 'package:repege/src/sheets/domain/bloc/sheet_bloc.dart';
import 'package:repege/src/sheets/domain/cubit/sheet_update_cubit.dart';
import 'package:repege/src/sheets/domain/entities/skill.dart';

class SkillList extends StatefulWidget {
  const SkillList({super.key});

  @override
  State<SkillList> createState() => _SkillListState();
}

class _SkillListState extends State<SkillList> {
  Map<String, List<Skill>> _computeSkillMapByAttribute(List<Skill> skills) {
    return skills.fold({}, (group, element) {
      if (group.containsKey(element.attributeName)) {
        group[element.attributeName]!.add(element);
        return group;
      }
      group[element.attributeName] = [element];
      return group;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: FullScreenScroll(
        child: BlocBuilder<SheetBloc, SheetState>(
          builder: (context, state) {
            if (state is SheetLoaded) {
              final cubit = context.read<SheetUpdateCubit>();
              return Column(children: [
                AppBar(
                  automaticallyImplyLeading: false,
                  title: const Text('Perícias'),
                ),
                ..._computeSkillMapByAttribute(state.sheet.skills).entries.map((entry) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          entry.key,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      ...entry.value.map((skill) {
                        return CheckboxMenuButton(
                          value: skill.proficient,
                          onChanged: (value) {
                            cubit.updateSkill(
                              sheet: state.sheet,
                              name: skill.name,
                              value: value ?? false,
                            );
                          },
                          child: Text(skill.name),
                        );
                      }),
                    ],
                  );
                }).toList(),
              ]);
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
