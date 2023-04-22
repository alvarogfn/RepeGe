import 'package:flutter/material.dart';
import 'package:repege/pages/utils/loading_page.dart';
import 'package:repege/components/shared/helpers/loading_helper.dart';

class LoadingStreamHelper extends StatelessWidget {
  const LoadingStreamHelper(
      {required this.stream, required this.child, super.key});

  final Widget child;
  final Stream stream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (ctx, snapshot) {
        return LoadingHelper(
          snapshot.connectionState,
          onLoading: const LoadingPage(),
          onActive: child,
        );
      },
    );
  }
}
