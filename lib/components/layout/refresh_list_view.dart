import 'package:flutter/material.dart';
import 'package:repege/components/layout/full_screen_scroll.dart';
import 'package:repege/components/shared/loading.dart';

class RefreshListView<T> extends StatefulWidget {
  const RefreshListView({
    required this.future,
    required this.builder,
    this.empty,
    this.error,
    super.key,
  });

  final Future<List<T>> Function(BuildContext context) future;
  final Widget Function(BuildContext context, T value) builder;
  final Widget? empty;
  final Widget? error;

  @override
  State<RefreshListView<T>> createState() => _RefreshListViewState<T>();
}

class _RefreshListViewState<T> extends State<RefreshListView<T>> {
  Future<List<T>> _future = Future.value([]);

  Future<void> _handleRefresh(context) async {
    setState(() {
      _future = widget.future(context);
    });
  }

  @override
  void didUpdateWidget(covariant RefreshListView<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _handleRefresh(context);
  }

  @override
  void initState() {
    super.initState();
    _handleRefresh(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: _future,
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Loading();
        }

        if (snap.hasError) return refreshableWidget(context, widget.error);

        final items = snap.data ?? [];

        if (items.isEmpty) return refreshableWidget(context, widget.empty);

        return RefreshIndicator(
          onRefresh: () => _handleRefresh(context),
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return widget.builder(context, items[index]);
            },
          ),
        );
      },
    );
  }

  Widget refreshableWidget(BuildContext context, Widget? child) {
    return LayoutBuilder(builder: (context, viewport) {
      return RefreshIndicator(
        onRefresh: () => _handleRefresh(context),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            constraints: BoxConstraints(
              minWidth: viewport.maxWidth,
              minHeight: viewport.maxHeight,
            ),
            child: child ?? const SizedBox(),
          ),
        ),
      );
    });
  }
}
