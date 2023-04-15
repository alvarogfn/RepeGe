import 'package:flutter/material.dart';
import 'package:tcc/components/handlers/loading_handler.dart';
import 'package:tcc/pages/home_page.dart';
import 'package:tcc/pages/loading_page.dart';
import 'package:tcc/services/auth_service.dart';

class AuthStreamHelper extends StatelessWidget {
  const AuthStreamHelper({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AuthService().userChanges,
        builder: (ctx, snapshot) {
          final isAuth = snapshot.data?.uid;
          return LoadingHandler(
            snapshot.connectionState,
            onActive: isAuth == null ? child : const HomePage(),
            onLoading: const LoadingPage(),
          );
        });
  }
}
