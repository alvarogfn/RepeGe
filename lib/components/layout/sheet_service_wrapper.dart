import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:repege/domains/authentication/services/auth_service.dart";
import "package:repege/domains/sheet/services/sheet_service.dart";

class SheetServiceWrapper extends StatelessWidget {
  const SheetServiceWrapper({required this.builder, this.child, super.key});

  final Widget Function(BuildContext, Widget?)? builder;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<AuthService, SheetService>(
      create: (context) {
        final user = context.read<AuthService>().user!;
        return SheetService(user: user);
      },
      update: (context, value, _) => SheetService(user: value.user!),
      builder: builder,
      child: child,
    );
  }
}
