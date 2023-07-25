import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repege/modules/authentication/services/auth_service.dart';
import 'package:repege/modules/sheets/services/sheets_service.dart';

class SheetServiceWrapper extends StatelessWidget {
  const SheetServiceWrapper({required this.builder, this.child, super.key});

  final Widget Function(BuildContext, Widget?)? builder;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<AuthService, SheetsService>(
      create: (context) {
        final user = context.read<AuthService>().user!;
        return SheetsService(user: user);
      },
      update: (context, value, _) => SheetsService(user: value.user!),
      builder: builder,
      child: child,
    );
  }
}
