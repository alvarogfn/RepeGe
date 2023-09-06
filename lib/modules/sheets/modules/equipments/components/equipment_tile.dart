import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/components/delete_or_edit_dismissible.dart';
import 'package:repege/config/routes_name.dart';
import 'package:repege/modules/sheets/modules/equipments/components/equipment_armor.dart';
import 'package:repege/modules/sheets/modules/equipments/components/equipment_item.dart';
import 'package:repege/modules/sheets/modules/equipments/components/equipment_weapon.dart';
import 'package:repege/modules/sheets/modules/equipments/models/armor.dart';
import 'package:repege/modules/sheets/modules/equipments/models/equipment.dart';
import 'package:repege/modules/sheets/modules/equipments/models/equipment_types.dart';
import 'package:repege/modules/sheets/modules/equipments/models/weapon.dart';

class EquipmentTile extends StatelessWidget {
  const EquipmentTile(this.equipment, {super.key});

  final Equipment equipment;

  @override
  Widget build(BuildContext context) {

    return DeleteOrEditDismissible(
      id: equipment.id,
      onDelete: handleDelete,
      onEdit: handleEdit,
      child: getEquipmentCard(equipment),
    );
  }

  Widget getEquipmentCard(Equipment equipment) {
    if (equipment is Weapon) {
      return EquipmentWeapon(weapon: equipment);
    }

    if (equipment is Armor) {
      return EquipmentArmor(armor: equipment);
    }

    return EquipmentItem(equipment: equipment);
  }

  Future<bool> handleEdit(
    BuildContext context,
    DismissDirection direction,
  ) async {
    final editedEquipment = await context.pushNamed<Map<String, dynamic>>(
      RoutesName.equipmentsForm.name,
      extra: equipment,
    );

    if (editedEquipment == null) return false;

    editedEquipment.update('type', (type) => (type as EquipmentTypes).name);

    await equipment.ref.update(editedEquipment);

    return false;
  }

  Future<bool> handleDelete(
    BuildContext context,
    DismissDirection direction,
  ) async {
    final ScaffoldMessengerState messeger = ScaffoldMessenger.of(context);

    messeger.showSnackBar(
      SnackBar(content: Text('Deletando equipamento ${equipment.name}...')),
    );

    try {
      await equipment.ref.delete();
      if (context.mounted) {
        messeger.showSnackBar(
          const SnackBar(content: Text('Deletando com sucesso.')),
        );
      }
      return true;
    } catch (error) {
      messeger.showSnackBar(
        SnackBar(
          content: Text(
            'Não foi possível deletar ${equipment.name}, um erro aconteceu.',
          ),
        ),
      );
    }

    return false;
  }
}
