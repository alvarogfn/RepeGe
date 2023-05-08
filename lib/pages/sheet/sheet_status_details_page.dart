import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repege/models/dnd/sheets/sheet.dart';
import 'package:repege/services/auth_service.dart';

class SheetStatusDetailsPage extends StatelessWidget {
  const SheetStatusDetailsPage(this.sheetReference, {super.key});

  final DocumentSnapshot<Sheet?> sheetReference;

  Sheet get sheet => sheetReference.data()!;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, service, _) {
        return const Scaffold(
          body: Text(''),
        );
      },
    );
  }
}
