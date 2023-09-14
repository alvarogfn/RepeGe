import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/components/full_screen_scroll.dart';
import 'package:repege/config/routes_name.dart';
import 'package:repege/modules/sheets/models/character.dart';
import 'package:repege/modules/sheets/services/sheet_service.dart';
import 'package:repege/screens/loading_page.dart';

class SheetsCreateScreen extends StatefulWidget {
  const SheetsCreateScreen({super.key});

  @override
  State<SheetsCreateScreen> createState() => _SheetsCreateScreenState();
}

class _SheetsCreateScreenState extends State<SheetsCreateScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _loading = false;

  final characterNameController = TextEditingController();
  final characterClassController = TextEditingController();
  final characterRaceController = TextEditingController();
  final backgroundController = TextEditingController();
  final alignmentController = TextEditingController();
  final characteristicsController = TextEditingController();

  bool _validateForm() {
    final currentState = _formKey.currentState;
    if (currentState == null) return false;

    final isValid = currentState.validate();
    if (!isValid) return false;

    currentState.save();

    return true;
  }

  Future<void> _handleSubmit() async {
    final isValid = _validateForm();

    if (!isValid) return;

    try {
      setState(() => _loading = true);

      final Character character = Character(
        characterName: characterNameController.text,
        characterClass: characterClassController.text,
        characterRace: characterRaceController.text,
        background: backgroundController.text,
        alignment: alignmentController.text,
        characteristics: characteristicsController.text,
      );

      final sheetService = context.read<SheetService>();

      final sheet = await sheetService.post(character: character);

      if (context.mounted) {
        context.pushReplacementNamed(RoutesName.sheet.name, extra: sheet);
      }
    } catch (e) {
      rethrow;
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const LoadingPage();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Personagem'),
      ),
      body: FullScreenScroll(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Nome'),
                  controller: characterNameController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Classe'),
                  controller: characterClassController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Raça'),
                  controller: characterRaceController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Antepassado'),
                  controller: backgroundController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Alinhamento'),
                  controller: alignmentController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Características adicionais',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  controller: characteristicsController,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  maxLines: 5,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _handleSubmit,
                  child: const Text('Criar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
