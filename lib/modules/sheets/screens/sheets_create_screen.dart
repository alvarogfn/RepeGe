import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/components/full_screen_scroll.dart';
import 'package:repege/components/loading.dart';
import 'package:repege/config/routes_name.dart';
import 'package:repege/modules/sheets/components/character_avatar_picker.dart';
import 'package:repege/modules/sheets/components/sheet_form_create_field.dart';
import 'package:repege/modules/sheets/models/character.dart';
import 'package:repege/modules/user/services/user_service.dart';

class SheetsCreateScreen extends StatefulWidget {
  const SheetsCreateScreen({super.key});

  @override
  State<SheetsCreateScreen> createState() => _SheetsCreateScreenState();
}

class _SheetsCreateScreenState extends State<SheetsCreateScreen> {
  final CharacterForm characterForm = CharacterForm();
  final _formKey = GlobalKey<FormState>();

  Future<void> _handleSubmit() async {
    final formState = _formKey.currentState;

    if (!(formState != null && formState.validate())) return;

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const Dialog.fullscreen(
        child: Loading(),
      ),
    );

    try {
      final userService = context.read<UserService>();
      // final user = await userService..get();

      final character = characterForm.save();
      // final sheet = await Sheet.createSheet(user.data()!, character: character);

      if (context.mounted) context.pop();

      if (context.mounted) {
        context.pushReplacementNamed(
          RoutesName.sheet.name,
          pathParameters: {
            // 'id': sheet.id,
          },
        );
      }
    } catch (e) {
      context.pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível criar o personagem')),
      );
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Personagem'),
      ),
      body: FullScreenScroll(
        child: Column(
          children: [
            const CharacterAvatarPicker(),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Container(
                      padding: const EdgeInsets.only(top: 5, bottom: 25),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Características',
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 20),
                      ),
                    ),
                  ),
                  SheetField(
                    label: 'Nome',
                    controller: characterForm.characterName,
                  ),
                  SheetField(
                    label: 'Classe',
                    controller: characterForm.characterClass,
                  ),
                  SheetField(
                    label: 'Raça',
                    controller: characterForm.characterRace,
                  ),
                  SheetField(
                    label: 'Antepassado',
                    controller: characterForm.background,
                  ),
                  SheetField(
                    label: 'Alinhamento',
                    controller: characterForm.alignment,
                    textInputAction: TextInputAction.done,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: _handleSubmit,
                      child: const Text('Criar'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
