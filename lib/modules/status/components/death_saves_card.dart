import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repege/components/card_title.dart';
import 'package:repege/modules/sheet/sheet_service.dart';
import 'package:repege/modules/sheets/services/sheet.dart';
import 'package:repege/modules/status/models/status.dart';

class DeathSavesCard extends StatefulWidget {
  const DeathSavesCard({super.key});

  @override
  State<DeathSavesCard> createState() => _DeathSavesCardState();
}

class _DeathSavesCardState extends State<DeathSavesCard> {
  DeathSaves deathSaves = DeathSaves();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final sheet = context.watch<Sheet>();
    deathSaves = sheet.status.deathSaves;
  }

  Future<void> _reset() async {
    final sheet = context.read<Sheet>();
    final sheetService = context.read<SheetService>();
    final status = sheet.status;
    final deathSaves = status.deathSaves;
    deathSaves.failures = 0;
    deathSaves.sucesses = 0;
    status.deathSaves = deathSaves;
    await sheetService.update(status);
  }

  @override
  Widget build(BuildContext context) {
    return CardTitle(
      title: 'Salvamento',
      icon: InkWell(
        onTap: _reset,
        child: const Icon(Icons.restart_alt),
      ),
      marginBetween: 0,
      child: Column(
        children: [
          DeathSavesRow(
            title: 'Sucessos',
            selectedQuantity: deathSaves.sucesses,
            onChanged: (value) {
              deathSaves.sucesses = value;
            },
          ),
          DeathSavesRow(
            title: 'Falhas',
            selectedQuantity: deathSaves.failures,
            onChanged: (value) {
              deathSaves.failures = value;
            },
          ),
        ],
      ),
    );
  }
}

class DeathSavesRow extends StatefulWidget {
  const DeathSavesRow({
    super.key,
    required this.title,
    required this.selectedQuantity,
    required this.onChanged,
  });

  final String title;
  final void Function(int selectedQuantity) onChanged;
  final int selectedQuantity;

  @override
  State<DeathSavesRow> createState() => _DeathSavesRowState();
}

class _DeathSavesRowState extends State<DeathSavesRow> {
  List<int> selectedQuantity = [];

  int get amount => selectedQuantity.length - 1;

  void _add(int value) {
    setState(() => selectedQuantity.add(value));
    widget.onChanged(selectedQuantity.length);
  }

  void _remove(int value) {
    setState(() => selectedQuantity.remove(value));
    widget.onChanged(selectedQuantity.length);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final List<int> selectedQuantity = [];
    for (int i = 1; i <= widget.selectedQuantity; i++) {
      selectedQuantity.add(i);
    }
    setState(() => this.selectedQuantity = selectedQuantity);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.title,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const Spacer(),
        Checkbox(
          value: selectedQuantity.contains(1),
          onChanged: (value) {
            value == true ? _add(1) : _remove(1);
          },
        ),
        Checkbox(
          value: selectedQuantity.contains(2),
          onChanged: (value) {
            value == true ? _add(2) : _remove(2);
          },
        ),
        Checkbox(
          value: selectedQuantity.contains(3),
          onChanged: (value) {
            value == true ? _add(3) : _remove(3);
          },
        ),
      ],
    );
  }
}
