import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repege/core/widgets/full_screen_scroll.dart';
import 'package:repege/src/sheets/domain/bloc/sheet_bloc.dart';
import 'package:repege/src/sheets/domain/cubit/sheet_update_cubit.dart';
class SkillFloatingList extends StatefulWidget {
  const SkillFloatingList({super.key});

  @override
  State<SkillFloatingList> createState() => _SkillFloatingList();
}

class _SkillFloatingList extends State<SkillFloatingList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: FullScreenScroll(
        child: BlocBuilder<SheetBloc, SheetState>(
          builder: (context, state) {
            if (state is SheetLoaded) {
              final update = context.read<SheetUpdateCubit>().update;
              final sheet = state.sheet;
              return Column(children: [
                AppBar(
                  automaticallyImplyLeading: false,
                  title: const Text('Perícias'),
                ),
                ...sheet.skills.toMap().entries.map((entry) {
                  return CheckboxMenuButton(
                    value: entry.value,
                    onChanged: (value) {
                      update(sheet.copyWith(
                        skills: sheet.skills.copyWithMap({
                          entry.key: entry.value,
                        }),
                      ));
                    },
                    child: Text(entry.value),
                  );
                }),
              ]);
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
