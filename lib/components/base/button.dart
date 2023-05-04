import 'package:flutter/material.dart';

enum ButtonType { outlined, elevated, text }

class Button extends StatelessWidget {
  const Button({
    this.type = ButtonType.elevated,
    this.disabled = false,
    this.onPressed,
    this.onFocusChange,
    this.onHover,
    this.onLongPress,
    this.loading = false,
    this.alignment = Alignment.centerLeft,
    this.margin = const EdgeInsets.all(0),
    this.width = 100,
    this.height = 50,
    super.key,
    required this.child,
  });

  final ButtonType type;
  final bool disabled;
  final Widget child;
  final bool loading;
  final double width;
  final double height;
  final EdgeInsets margin;
  final Alignment alignment;
  final void Function()? onPressed;
  final void Function(bool?)? onFocusChange;
  final void Function(bool?)? onHover;
  final void Function()? onLongPress;

  Widget get _child => loading ? loadingWidget() : child;

  Widget loadingWidget() {
    return const AspectRatio(
      aspectRatio: 1,
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      alignment: alignment,
      child: SizedBox(
        width: width,
        height: height,
        child: Builder(
          builder: (context) {
            switch (type) {
              case ButtonType.elevated:
                return ElevatedButton(
                  onPressed: onPressed,
                  onFocusChange: onFocusChange,
                  onHover: onHover,
                  onLongPress: onLongPress,
                  child: _child,
                );

              case ButtonType.text:
                return TextButton(
                  onPressed: onPressed,
                  onFocusChange: onFocusChange,
                  onHover: onHover,
                  onLongPress: onLongPress,
                  child: _child,
                );

              case ButtonType.outlined:
                return OutlinedButton(
                  onPressed: onPressed,
                  onFocusChange: onFocusChange,
                  onHover: onHover,
                  onLongPress: onLongPress,
                  child: _child,
                );
            }
          },
        ),
      ),
    );
  }
}
