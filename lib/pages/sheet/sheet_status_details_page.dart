import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:repege/components/shared/circle_icon.dart';
import 'package:repege/models/dnd/sheets/sheet.dart';

class SheetStatusDetailsPage extends StatefulWidget {
  const SheetStatusDetailsPage({required this.sheet, super.key});

  final DocumentSnapshot<Sheet?> sheet;

  @override
  State<SheetStatusDetailsPage> createState() => _SheetStatusDetailsPageState();
}

class _SheetStatusDetailsPageState extends State<SheetStatusDetailsPage> {
  Sheet get sheet => widget.sheet.data()!;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Status'),
      floatingActionButton: _FloatingActionButton(),
    );
  }
}

class _FloatingActionButton extends StatelessWidget {
  const _FloatingActionButton();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Material(
        child: PopupMenuButton(
          itemBuilder: (context) => [
            const PopupMenuItem(child: Text('2')),
            const PopupMenuItem(child: Text('3')),
          ],
          child: const CircleIcon(
            height: 50,
            width: 50,
            backgroundColor: Colors.black,
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
