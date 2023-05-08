import 'package:flutter/widgets.dart';

class FullScreenScroll extends StatelessWidget {
  const FullScreenScroll({
    required this.child,
    this.physics,
    super.key,
  });

  final Widget child;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, viewport) => SingleChildScrollView(
        physics: physics,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: viewport.maxHeight,
            minWidth: viewport.minWidth,
          ),
          child: child,
        ),
      ),
    );
  }
}
