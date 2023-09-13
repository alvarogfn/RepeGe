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
  @override
  void initState() {
    super.initState();
    final authService = context.read<AuthService>();
    if (authService.credential?.emailVerified == false) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                'É necessário verificar o email.',
              ),
              content: Text('Você precisa confirmar o email ${authService.user!.email}'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    authService.credential!.sendEmailVerification();
                  },
                  child: const Text('Re-enviar confirmação'),
                )
              ],
            );
          },
        ).then(
          (value) => authService.signOut(),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Início')),
      drawer: CustomDrawer(),
      body: Scaffold(
        body: TextButton(
          onPressed: () {},
          child: const Text('hehe'),
        ),
      ),
    );
  }
}
