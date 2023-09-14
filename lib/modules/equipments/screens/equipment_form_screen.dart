import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/components/full_screen_scroll.dart';
import 'package:repege/modules/sheets/components/sheet_dropdown_menu.dart';
import 'package:repege/modules/equipments/components/equipment_form_field.dart';
import 'package:repege/modules/equipments/models/equipment.dart';
import 'package:repege/modules/equipments/models/equipment_types.dart';

class EquipmentFormScreen extends StatefulWidget {
  const EquipmentFormScreen(this.equipment, {super.key});

  final Equipment? equipment;

  @override
  State<EquipmentFormScreen> createState() => _EquipmentFormScreenState();
}

class _EquipmentFormScreenState extends State<EquipmentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  EquipmentTypes type = EquipmentTypes.item;
  Map<String, dynamic> data = {};

  Future<void> save(BuildContext context) async {
    final currentState = _formKey.currentState;
    if (currentState == null) return;

    final isValid = currentState.validate();
    if (!isValid) return;

    data['type'] = type;
    context.pop(data);
  }

  @override
  void initState() {
    super.initState();
    if (widget.equipment != null) {
      setState(() {
        data = widget.equipment!.toMap();
        type = widget.equipment!.type;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crie um equipamento'),
        actions: [
          IconButton(
            onPressed: () => save(context),
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: FullScreenScroll(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SheetDropdownMenu(
                labelText: 'Tipo de Item',
                initialSelection: type,
                items: EquipmentTypes.values,
                builder: (item) => DropdownMenuEntry(
                  value: item,
                  label: item.translation,
                  leadingIcon: item.icon,
                ),
                onSelected: (type) {
                  if (type == null) return;
                  setState(() => this.type = type);
                },
              ),
              const SizedBox(height: 15),
              const Text(
                'Detalhes',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 15),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    EquipmentFormField(
                      labelText: 'Nome',
                      initialValue: data['name'],
                      onChanged: (name) => data['name'] = name,
                    ),
                    EquipmentFormField(
                      labelText: 'Descrição',
                      initialValue: data['description'],
                      maxLines: 4,
                      onChanged: (description) {
                        data['description'] = description;
                      },
                    ),
                    EquipmentFormField(
                      labelText: 'Preço',
                      initialValue: data['price'],
                      hintText: 'Ex: 2po',
                      onChanged: (price) => data['price'] = price,
                    ),
                    EquipmentFormField(
                      labelText: 'Peso',
                      initialValue: data['weight'],
                      hintText: 'Ex: 2Kg',
                      onChanged: (weight) => data['weight'] = weight,
                    ),
                    if (type == EquipmentTypes.weapon) ...weaponForm(),
                    if (type == EquipmentTypes.armor) ...armorForm()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> weaponForm() {
    return [
      EquipmentFormField(
        labelText: 'Tipo de Arma',
        initialValue: data['kind'],
        hintText: 'Ex: Arma de Duas Mãos',
        onChanged: (kind) {
          data['kind'] = kind;
        },
      ),
      EquipmentFormField(
        labelText: 'Dano',
        initialValue: data['damage'],
        hintText: 'Ex: 2D8 Perfurante',
        onChanged: (damage) {
          data['damage'] = damage;
        },
      ),
    ];
  }

  List<Widget> armorForm() {
    return [
      EquipmentFormField(
        labelText: 'Tipo de Armadura',
        hintText: 'Ex: Armadura Pesada',
        initialValue: data['kind'],
        onChanged: (kind) => data['kind'] = kind,
      ),
      EquipmentFormField(
        labelText: 'Classe de Armadura(CA)',
        hintText: 'Ex: 14 + Destreza',
        initialValue: data['armorClass'],
        onChanged: (armorClass) => data['armorClass'] = armorClass,
      ),
      EquipmentFormField(
        labelText: 'Força requerida',
        hintText: 'Ex: 15',
        initialValue: data['minStrength'],
        keyboardType: TextInputType.number,
        onChanged: (minStrength) => data['minStrength'] = minStrength,
      ),
    ];
  }
}
