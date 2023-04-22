import 'package:flutter/widgets.dart';

class FullScreenScroll extends StatelessWidget {
  const FullScreenScroll({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, viewport) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: viewport.maxHeight),
          child: child,
        ),
      ),
    );
  }
}
