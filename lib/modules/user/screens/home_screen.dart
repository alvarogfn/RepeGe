import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repege/modules/auth/services/auth_service.dart';
import 'package:repege/modules/user/components/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _signOutDialog(AuthService authService) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'É necessário verificar o email.',
          ),
          content: Text('Você precisa confirmar o email ${authService.user?.email}'),
          actions: [
            ElevatedButton(
              onPressed: () {
                authService.user?.sendEmailVerification();
              },
              child: const Text('Re-enviar confirmação'),
            )
          ],
        );
      },
    );

    await authService.signOut();
  }

  @override
  void initState() {
    super.initState();
    final authService = context.read<AuthService>();
    if (authService.user == null) return;
    if (authService.user!.emailVerified) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _signOutDialog(authService);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Início')),
      drawer: const CustomDrawer(),
      body: const Scaffold(
        body: Center(
          child: Text('O que vamos jogar hoje?'),
        ),
      ),
    );
  }
}
