import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/core/widgets/full_screen_scroll.dart';
import 'package:repege/src/sheets/data/models/skills_model.dart';

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
          ...skills.toMap().entries.map((entry) {
            return CheckboxMenuButton(
              value: entry.value,
              onChanged: (value) {
                setState(() {
                  skills = skills.copyWithMap({entry.key: value ?? false});
                });
              },
              child: Text(entry.key),
            );
          }),
        ]),
      ),
    );
  }
}
