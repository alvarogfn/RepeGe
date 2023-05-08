import 'package:flutter/material.dart';
import 'package:repege/components/atoms/loading.dart';

class StreamListView<T> extends StatelessWidget {
  const StreamListView({
    required this.stream,
    required this.builder,
    this.empty,
    this.error,
    super.key,
  });

  final Stream<List<T>> stream;
  final Widget Function(BuildContext context, T value) builder;
  final Widget? empty;
  final Widget? error;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<T>>(
      stream: stream,
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Loading();
        }

        if (snap.hasError) return error ?? const SizedBox();

        final items = snap.data ?? [];

        if (items.isEmpty) return empty ?? const SizedBox();

        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return builder(context, items[index]);
          },
        );
      },
    );
  }
}
