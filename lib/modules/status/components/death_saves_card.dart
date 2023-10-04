import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repege/components/card_title.dart';
import 'package:repege/modules/sheets/services/sheet.dart';

class DeathSavesCard extends StatelessWidget {
  const DeathSavesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CardTitle(
      title: 'Salvamento',
      icon: InkWell(
        onTap: () {
          context.read<Sheet>().ref.update({
            'status.deathSaves': {
              'sucesses': 0,
              'failures': 0,
            }
          });
        },
        child: const Icon(Icons.restart_alt),
      ),
      marginBetween: 0,
      child: Consumer<Sheet>(
        builder: (context, sheet, _) {
          return Column(
            children: [
              DeathSavesRow(
                title: 'Sucessos',
                quantity: sheet.status.deathSaves.sucesses,
                onChanged: (value) {
                  sheet.ref.update({'status.deathSaves.sucesses': value});
                },
              ),
              DeathSavesRow(
                title: 'Falhas',
                quantity: sheet.status.deathSaves.failures,
                onChanged: (value) {
                  sheet.ref.update({'status.deathSaves.failures': value});
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class DeathSavesRow extends StatelessWidget {
  const DeathSavesRow({
    super.key,
    required this.title,
    required this.quantity,
    required this.onChanged,
  });

  final String title;
  final void Function(int quantity) onChanged;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const Spacer(),
        Slider(
          value: quantity.toDouble(),
          onChanged: (value) {
            onChanged(value.toInt());
          },
          max: 2,
          divisions: 2,
          label: quantity.toInt().toString(),
        ),
      ],
    );
  }
}
