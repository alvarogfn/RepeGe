import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showTextSnackbar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}
