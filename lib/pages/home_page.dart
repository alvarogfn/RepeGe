import 'dart:async';

import 'package:flutter/material.dart';
import 'package:repege/components/shared/custom_drawer.dart';
import 'package:repege/pages/login_page.dart';
import 'package:repege/services/auth_service.dart';
import 'package:repege/utils/not_verified_snackbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("RepeGe")),
      drawer: const CustomDrawer(),
    );
  }
}
