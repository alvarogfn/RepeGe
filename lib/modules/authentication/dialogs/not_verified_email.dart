import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/modules/shared/components/paragraph.dart';
import 'package:repege/modules/authentication/services/auth_service.dart';

Future<dynamic> notVerifiedEmail(
  BuildContext context, {
  required String email,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Email não confirmado.'),
        content: Paragraph(
          'O endereço de email **$email** ainda não foi confirmado na plataforma.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              final authService = context.read<AuthService>();
              authService.sendEmailVerification();
              context.pop();
            },
            child: const Text('Reenviar Confirmação.'),
          )
        ],
      );
    },
  );
}
