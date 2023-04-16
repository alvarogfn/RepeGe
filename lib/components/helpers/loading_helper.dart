import 'package:flutter/material.dart';

class LoadingHelper extends StatelessWidget {
  const LoadingHelper(
    this.connectionState, {
    required this.onActive,
    required this.onLoading,
    super.key,
  });

  final ConnectionState connectionState;
  final Widget onActive;
  final Widget onLoading;

  @override
  Widget build(BuildContext context) {
    switch (connectionState) {
      case ConnectionState.active:
        return onActive;
      default:
        return onLoading;
    }
  }
}