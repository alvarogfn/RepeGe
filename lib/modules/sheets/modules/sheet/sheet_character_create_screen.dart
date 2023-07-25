import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/modules/shared/components/headline.dart';
import 'package:repege/modules/shared/components/full_screen_scroll.dart';
import 'package:repege/icons/rpg_icons.dart';
import 'package:repege/models/dnd/sheets/sheet.dart';
import 'package:repege/modules/shared/utils/validations/required_validation.dart';
import 'package:repege/modules/sheets/components/sheet_text_field.dart';
import 'package:repege/modules/sheets/sheet_character_profile_picture.dart';

class SheetCharacterCreateScreen extends StatefulWidget {
  const SheetCharacterCreateScreen({super.key});

  @override
  State<SheetCharacterCreateScreen> createState() =>
      _SheetCharacterCreateScreenState();
}

class _SheetCharacterCreateScreenState
    extends State<SheetCharacterCreateScreen> {
  final SheetModel _sheet = SheetModel();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Personagem'),
        actions: [
          IconButton(
            onPressed: () {
              final isValid = _formKey.currentState?.validate();
              if (isValid == true) context.pop<SheetModel>(_sheet);
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: FullScreenScroll(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SheetCharacterProfilePicture(
                image: _sheet.avatar,
                onChanged: (file) => setState(() => _sheet.avatarFile = file),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
                child: Column(
                  children: [
                    title('Informações do Personagem'),
                    SheetTextField(
                      label: 'Nome',
                      placeholder: 'Gandalf',
                      margin: const EdgeInsets.symmetric(vertical: 7.5),
                      onChanged: (value) => _sheet.characterName = value ?? '',
                      prefixIcon: Rpg.helmet,
                      validations: [RequiredValidation()],
                      action: TextInputAction.next,
                    ),
                    SheetTextField(
                      label: 'Classe',
                      placeholder: 'Mago',
                      onChanged: (value) => _sheet.characterClass = value ?? '',
                      prefixIcon: Rpg.crossed_swords,
                      margin: const EdgeInsets.symmetric(vertical: 7.5),
                      validations: [RequiredValidation()],
                      action: TextInputAction.next,
                    ),
                    SheetTextField(
                      label: 'Raça',
                      placeholder: 'Humano',
                      onChanged: (value) => _sheet.characterRace = value ?? '',
                      prefixIcon: Rpg.player,
                      margin: const EdgeInsets.symmetric(vertical: 7.5),
                      validations: [RequiredValidation()],
                      action: TextInputAction.next,
                    ),
                    SheetTextField(
                      label: 'Antepassado',
                      placeholder: 'Eremita',
                      onChanged: (value) => _sheet.background = value ?? '',
                      prefixIcon: Rpg.dead_tree,
                      margin: const EdgeInsets.symmetric(vertical: 7.5),
                      validations: [RequiredValidation()],
                      action: TextInputAction.next,
                    ),
                    SheetTextField(
                      label: 'Alinhamento',
                      placeholder: 'Neutro/Bom',
                      onChanged: (value) => _sheet.alignment = value ?? '',
                      prefixIcon: Rpg.player_pyromaniac,
                      margin: const EdgeInsets.symmetric(vertical: 7.5),
                      validations: [RequiredValidation()],
                      action: TextInputAction.done,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container title(String text) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 20, bottom: 10),
      child: Headline(text, fontSize: 22, fontWeight: FontWeight.w900),
    );
  }
}
