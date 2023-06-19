import "package:flutter/material.dart";

enum ButtonType { outlined, elevated, text }

class SignupSubmitButton extends StatelessWidget {
  const SignupSubmitButton({
    required this.onPressed,
    required this.snapshot,
    super.key,
  });

  bool get loading => snapshot.connectionState == ConnectionState.waiting;

  Widget get child {
    if (loading) {
      return const CircularProgressIndicator(
        color: Colors.white,
      );
    }
    return const Text("Cadastrar-se");
  }

  final AsyncSnapshot snapshot;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: loading ? null : onPressed,
        child: child,
      ),
    );
  }
}
