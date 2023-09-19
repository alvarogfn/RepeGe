import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/components/full_screen_scroll.dart';
import 'package:repege/config/routes_name.dart';
import 'package:repege/modules/auth/services/auth_service.dart';
import 'package:repege/modules/sheets/models/character.dart';
import 'package:repege/modules/sheets/services/sheets_service.dart';

class SheetsCreateScreen extends StatefulWidget {
  const SheetsCreateScreen({super.key});

  @override
  State<SheetsCreateScreen> createState() => _SheetsCreateScreenState();
}

class _SheetsCreateScreenState extends State<SheetsCreateScreen> {
  final _formKey = GlobalKey<FormState>();

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

  Future<void> _handleSubmit(BuildContext context) async {
    final isValid = _validateForm();

    if (!isValid) return;

    try {
      final Character character = Character(
        characterName: characterNameController.text,
        characterClass: characterClassController.text,
        characterRace: characterRaceController.text,
        background: backgroundController.text,
        alignment: alignmentController.text,
        characteristics: characteristicsController.text,
      );

      final sheetService = context.read<SheetsService>();

      final sheet = await sheetService.post(character: character);

      if (this.context.mounted) {
        // ignore: use_build_context_synchronously
        this.context.pushReplacementNamed(RoutesName.sheet.name, pathParameters: {'id': sheet.id});
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Personagem'),
      ),
      body: ChangeNotifierProxyProvider<AuthService, SheetsService>(
        create: (context) => SheetsService(
          context.read<AuthService>().user!,
        ),
        update: (context, authService, sheetService) {
          final user = context.read<AuthService>().user!;

          if (sheetService == null) return SheetsService(user);
          sheetService.user = user;

          return sheetService;
        },
        builder: (context, child) {
          return FullScreenScroll(
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
                      onPressed: () => _handleSubmit(context),
                      child: const Text('Criar'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
