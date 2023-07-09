import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton(
    this.text, {
    required this.onPressed,
    required this.snapshot,
    super.key,
  });

  final String text;

  bool get loading => snapshot.connectionState == ConnectionState.waiting;

  Widget get child {
    if (loading) {
      return const CircularProgressIndicator(
        color: Colors.white,
      );
    }
    return Text(text);
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
        child: SizedBox(width: 90, height: 20, child: Center(child: child)),
      ),
    );
  }
}
