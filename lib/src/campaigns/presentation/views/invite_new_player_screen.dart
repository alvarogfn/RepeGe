import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/core/utils/validations/alphanum_validation.dart';
import 'package:repege/core/utils/validations/required_validation.dart';
import 'package:repege/core/utils/validations/validations.dart';

class InviteNewPlayerScreen extends StatefulWidget {
  const InviteNewPlayerScreen({
    super.key,
  });

  @override
  State<InviteNewPlayerScreen> createState() => _InviteNewPlayerScreenState();
}

class _InviteNewPlayerScreenState extends State<InviteNewPlayerScreen> {
  String _nickname = '';
  final _formKey = GlobalKey<FormState>();

  bool _validateForm() {
    final currentState = _formKey.currentState;
    if (currentState == null) return false;

    final isValid = currentState.validate();
    if (!isValid) return false;

    currentState.save();

    return true;
  }

  void _handleSubmit() async {
    if (!_validateForm()) return;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Confirmar convite de $_nickname?',
            style: const TextStyle(color: Colors.black),
          ),
          actions: [ElevatedButton(onPressed: () => context.pop(true), child: const Text('Sim'))],
        );
      },
    );

    if (confirm == true && context.mounted) {
      context.pop(_nickname);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Convidar novo participante')),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
              key: _formKey,
              child: TextFormField(
                initialValue: _nickname,
                decoration: const InputDecoration(
                  labelText: 'Nome de usuário',
                ),
                onSaved: (value) => setState(() => _nickname = value ?? ''),
                validator: (value) => Validator.validateWith(value, [
                  RequiredValidation(),
                  AlphanumValidation(),
                ]),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _handleSubmit,
              child: const Text('Convidar'),
            ),
          ],
        ),
      ),
    );
  }
}
