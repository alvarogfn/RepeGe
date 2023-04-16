import 'package:flutter/material.dart';
import 'package:tcc/pages/loading_page.dart';
import 'package:tcc/components/helpers/loading_helper.dart';

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
