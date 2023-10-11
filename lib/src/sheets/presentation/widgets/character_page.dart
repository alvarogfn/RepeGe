import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repege/core/widgets/full_screen_scroll.dart';
import 'package:repege/src/sheets/data/models/sheet_model.dart';
import 'package:repege/src/sheets/domain/cubit/sheet_update_cubit.dart';
import 'package:repege/src/sheets/presentation/widgets/editable_text_form_field.dart';

class CharacterPage extends StatelessWidget {
  const CharacterPage(this.sheet, {super.key});
  final SheetModel sheet;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Caracteristicas'),
        automaticallyImplyLeading: false,
      ),
      body: FullScreenScroll(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Builder(
            builder: (context) {
              update(SheetModel data) => context.read<SheetUpdateCubit>().updateSheet(
                    id: sheet.id,
                    newData: data.toMap(),
                  );

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  EditableTextFormField(
                    label: 'Nome',
                    initialValue: sheet.characterName,
                    onSaved: (value) => update(sheet.copyWith(
                      characterName: value,
                    )),
                    border: InputBorder.none,
                  ),
                  EditableTextFormField(
                    label: 'Classe',
                    initialValue: sheet.characterClass,
                    onSaved: (value) => update(sheet.copyWith(
                      characterClass: value,
                    )),
                    border: InputBorder.none,
                  ),
                  EditableTextFormField(
                    label: 'Nível',
                    initialValue: sheet.characterLevel.toString(),
                    onSaved: (value) => update(sheet.copyWith(
                      characterLevel: int.parse(value ?? '0'),
                    )),
                    border: InputBorder.none,
                    keyboardType: TextInputType.number,
                  ),
                  EditableTextFormField(
                    label: 'Raça',
                    initialValue: sheet.characterRace,
                    onSaved: (value) => update(sheet.copyWith(
                      characterRace: value,
                    )),
                    border: InputBorder.none,
                  ),
                  EditableTextFormField(
                    label: 'Alinhamento',
                    initialValue: sheet.alignment,
                    onSaved: (value) => update(sheet.copyWith(
                      alignment: value,
                    )),
                    border: InputBorder.none,
                  ),
                  EditableTextFormField(
                    label: 'Antepassado',
                    initialValue: sheet.background,
                    onSaved: (value) => update(sheet.copyWith(
                      background: value,
                    )),
                    border: InputBorder.none,
                  ),
                  EditableTextFormField(
                    label: 'Línguas',
                    initialValue: sheet.languages,
                    onSaved: (value) => update(sheet.copyWith(
                      languages: value,
                    )),
                    border: InputBorder.none,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
