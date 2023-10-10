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
              final sheetCubit = context.read<SheetUpdateCubit>();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  EditableTextFormField(
                    label: 'Nome',
                    initialValue: sheet.characterName,
                    onSaved: (value) => sheetCubit.updateSheet(sheet.copyWith(
                      characterName: value,
                    )),
                    border: InputBorder.none,
                  ),
                  EditableTextFormField(
                    label: 'Classe',
                    initialValue: sheet.characterClass,
                    onSaved: (value) => sheetCubit.updateSheet(sheet.copyWith(
                      characterClass: value,
                    )),
                    border: InputBorder.none,
                  ),
                  EditableTextFormField(
                    label: 'Nível',
                    initialValue: sheet.characterLevel.toString(),
                    onSaved: (value) => sheetCubit.updateSheet(sheet.copyWith(
                      characterLevel: int.parse(value ?? '0'),
                    )),
                    border: InputBorder.none,
                    keyboardType: TextInputType.number,
                  ),
                  EditableTextFormField(
                    label: 'Raça',
                    initialValue: sheet.characterRace,
                    onSaved: (value) => sheetCubit.updateSheet(sheet.copyWith(
                      characterRace: value,
                    )),
                    border: InputBorder.none,
                  ),
                  EditableTextFormField(
                    label: 'Alinhamento',
                    initialValue: sheet.alignment,
                    onSaved: (value) => sheetCubit.updateSheet(sheet.copyWith(
                      alignment: value,
                    )),
                    border: InputBorder.none,
                  ),
                  EditableTextFormField(
                    label: 'Antepassado',
                    initialValue: sheet.background,
                    onSaved: (value) => sheetCubit.updateSheet(sheet.copyWith(
                      background: value,
                    )),
                    border: InputBorder.none,
                  ),
                  EditableTextFormField(
                    label: 'Línguas',
                    initialValue: sheet.languages,
                    onSaved: (value) => sheetCubit.updateSheet(sheet.copyWith(
                      languages: value,
                    )),
                    border: InputBorder.none,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Detalhes Adicionais',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10),
                  EditableTextFormField(
                    label: 'Caracteristicas e talentos',
                    initialValue: sheet.characteristics,
                    maxLines: 5,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    onSaved: (value) => sheetCubit.updateSheet(sheet.copyWith(
                      characteristics: value,
                    )),
                  ),
                  EditableTextFormField(
                    label: 'Habilidades e perícias',
                    initialValue: sheet.skills,
                    maxLines: 5,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    onSaved: (value) => sheetCubit.updateSheet(sheet.copyWith(
                      skills: value,
                    )),
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
