import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:repege/components/atoms/paragraph.dart";
import "package:repege/config/routes_name.dart";

class SignupButton extends StatelessWidget {
  const SignupButton({required this.onPop, super.key});

  final void Function(String?) onPop;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: () async {
          final result = await context.pushNamed<String>(
            RoutesName.signup.name,
          );
          onPop(result);
        },
        child: const Paragraph(
          "Não possui uma conta? **Registre-se!**",
        ),
      ),
    );
  }
}
