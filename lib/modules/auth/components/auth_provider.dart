import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repege/modules/auth/services/auth_service.dart';

class AuthProvider extends StatelessWidget {
  const AuthProvider({required this.builder, required this.child, super.key});

  final Widget? child;
  final Widget Function(BuildContext context, Widget? child)? builder;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthService(),
      builder: builder,
      child: child,
    );
  }
}
