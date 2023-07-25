import 'package:flutter/material.dart';
import 'package:repege/modules/shared/components/loading.dart';

class StreamListView<T> extends StatelessWidget {
  const StreamListView({
    required this.stream,
    required this.builder,
    this.emptyWidget,
    this.errorBuilder,
    super.key,
  });

  final Stream<List<T>> stream;
  final Widget Function(BuildContext context, T value) builder;
  final Widget Function(BuildContext context, Object error)? errorBuilder;
  final Widget? emptyWidget;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<T>>(
      stream: stream,
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Loading();
      }

        if (snap.hasError) {
          if (errorBuilder == null) return Text(snap.error.toString());
          return errorBuilder!(context, snap.error!);
        }

        final items = snap.data ?? [];
        if (items.isEmpty) {
          return emptyWidget ??
              const Center(
                child: Text('A lista está vazia.'),
              );
        }

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
