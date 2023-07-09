import 'package:flutter/material.dart';

Future<void> sendEmailConfirmation(
  BuildContext context, {
  required String email,
}) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Confirmação de E-mail.'),
        content: Text(
          'Uma confirmação de email foi enviada para $email. Você precisa confirmar antes de poder se entrar.',
        ),
      );
    },
  );
}
