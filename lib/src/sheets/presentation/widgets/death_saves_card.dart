import 'package:flutter/material.dart';

class DeathSavesCard extends StatelessWidget {
  const DeathSavesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('');

    // return CardTitle(
    //   title: 'Salvamento',
    //   // icon: InkWell(
    //   //   onTap: () {
    //   //     context.read<Sheet>().ref.update({
    //   //       'status.deathSaves': {
    //   //         'sucesses': 0,
    //   //         'failures': 0,
    //   //       }
    //   //     });
    //   //   },
    //   //   child: const Icon(Icons.restart_alt),
    //   // ),
    //   marginBetween: 0,
    //   child: Consumer<Sheet>(
    //     builder: (context, sheet, _) {
    //       return Column(
    //         children: [
    //           DeathSavesRow(
    //             title: 'Sucessos',
    //             quantity: sheet.status.deathSaves.sucesses,
    //             onChanged: (value) {
    //               sheet.ref.update({'status.deathSaves.sucesses': value});
    //             },
    //           ),
    //           DeathSavesRow(
    //             title: 'Falhas',
    //             quantity: sheet.status.deathSaves.failures,
    //             onChanged: (value) {
    //               sheet.ref.update({'status.deathSaves.failures': value});
    //             },
    //           ),
    //         ],
    //       );
    //     },
    //   ),
    // );
  }
}

class DeathSavesRow extends StatefulWidget {
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
  State<DeathSavesRow> createState() => _DeathSavesRowState();
}

class _DeathSavesRowState extends State<DeathSavesRow> {
  double _value = 0;

  @override
  void initState() {
    super.initState();
    setState(() => _value = widget.quantity.toDouble());
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
        Slider(
          value: _value,
          onChangeEnd: (value) {
            widget.onChanged(value.toInt());
          },
          onChanged: (value) {
            setState(() => _value = value);
          },
          max: 2,
          divisions: 2,
          label: _value.toInt().toString(),
        ),
      ],
    );
  }
}