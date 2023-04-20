import 'dart:async';

import 'package:flutter/material.dart';
import 'package:repege/components/custom_drawer.dart';
import 'package:repege/pages/login_page.dart';
import 'package:repege/services/auth_service.dart';
import 'package:repege/utils/not_verified_snackbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = AuthService().userChanges.listen((user) {
      if (user == null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (ctx) => const LoginPage(),
        ));

        return;
      }

      if (AuthService.instance.currentUser?.emailVerified != true) {
        notVerifiedSnackBar(context, user.email);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("RepeGe")),
      drawer: const CustomDrawer(),
    );
  }
}
