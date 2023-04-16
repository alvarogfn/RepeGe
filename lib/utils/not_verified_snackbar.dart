import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> notVerifiedSnackBar(
  BuildContext context,
  String email,
) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(minutes: 1),
      content: RichText(
        text: TextSpan(
          children: [
            const TextSpan(
              text: "Uma verificação de email foi enviada para: ",
            ),
            TextSpan(
              text: email,
              style: const TextStyle(fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    ),
  );
}
