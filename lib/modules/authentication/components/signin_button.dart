import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/config/routes_name.dart';
import 'package:repege/components/paragraph.dart';

class SigninButton extends StatelessWidget {
  const SigninButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: () => context.pushNamed<String>(RoutesName.signin.name),
        child: const Paragraph('Não possui uma conta? **Registre-se!**'),
      ),
    );
  }
}
