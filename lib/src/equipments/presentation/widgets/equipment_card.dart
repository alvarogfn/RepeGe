import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/src/equipments/domain/entities/equipment.dart';

class EquipmentCard extends StatelessWidget {
  const EquipmentCard({required this.equipment, this.onDismissed, super.key});

  final void Function(DismissDirection)? onDismissed;
  final Equipment equipment;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(equipment.id),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        color: Colors.red,
        child: const Icon(
          Icons.delete_forever,
          color: Colors.white,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) => showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: const Text('Confirmar?'),
              actions: [
                ElevatedButton(
                  onPressed: () => context.pop(true),
                  child: const Text('sim'),
                )
              ],
            );
          }),
      onDismissed: onDismissed,
      child: ListTile(
        onTap: () => showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                equipment.name,
                style: const TextStyle(color: Colors.black),
              ),
              content: Text(
                equipment.description,
                textAlign: TextAlign.left,
              ),
            );
          },
        ),
        title: Text(equipment.name),
        trailing: Text('${equipment.price} | ${equipment.weight}'),
        subtitle: Text(
          equipment.description,
          maxLines: 2,
          style: const TextStyle(overflow: TextOverflow.ellipsis),
          textAlign: TextAlign.justify,
        ),
        minLeadingWidth: 20,
        leading: const SizedBox(
          width: 20,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Icon(Icons.backpack_outlined, size: 25, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
