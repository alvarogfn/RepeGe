import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/core/utils/validations/required_validation.dart';
import 'package:repege/core/utils/validations/validations.dart';
import 'package:repege/core/widgets/full_screen_scroll.dart';
import 'package:repege/src/authentication/domain/cubit/authentication_cubit.dart';
import 'package:repege/src/sheets/data/models/sheet_model.dart';

class SheetsCreateScreen extends StatefulWidget {
  const SheetsCreateScreen({super.key});

  @override
  State<SheetsCreateScreen> createState() => _SheetsCreateScreenState();
}

class _SheetsCreateScreenState extends State<SheetsCreateScreen> {
  final _formKey = GlobalKey<FormState>();

  SheetModel sheet = SheetModel.empty();

  bool _validateForm() {
    final currentState = _formKey.currentState;
    if (currentState == null) return false;

    final isValid = currentState.validate();
    if (!isValid) return false;

    currentState.save();

    return true;
  }

  void _handleSubmit(BuildContext context) {
    if (!_validateForm()) return;
    final authState = context.read<AuthenticationCubit>().state;

    if (authState is Unauthenticated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Não foi possível criar a sua ficha. Tente sair e entrar novamente da sua conta.'),
        ),
      );

      return;
    }

    if (authState is Authenticated) {
      return context.pop(sheet);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  onChanged: (value) => sheet = sheet.copyWith(characterName: value),
                  validator: (value) => Validator.validateWith(value, [RequiredValidation()]),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Classe'),
                  onChanged: (value) => sheet = sheet.copyWith(characterClass: value),
                  validator: (value) => Validator.validateWith(value, [RequiredValidation()]),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Raça'),
                  onChanged: (value) => sheet = sheet.copyWith(characterRace: value),
                  validator: (value) => Validator.validateWith(value, [RequiredValidation()]),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Antepassado'),
                  onChanged: (value) => sheet = sheet.copyWith(background: value),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Alinhamento'),
                  onChanged: (value) => sheet = sheet.copyWith(alignment: value),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
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
      ),
    );
  }
}
