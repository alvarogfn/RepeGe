import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/core/icons/rpg_icons.dart';
import 'package:repege/core/routes/routes_name.dart';
import 'package:repege/core/services/injection_container.dart';
import 'package:repege/core/widgets/card_title.dart';
import 'package:repege/core/widgets/text_form_field_bottom_sheet.dart';
import 'package:repege/src/equipments/data/models/equipment_model.dart';
import 'package:repege/src/equipments/domain/bloc/equipment_bloc.dart';
import 'package:repege/src/sheets/data/models/sheet_model.dart';
import 'package:repege/src/sheets/domain/cubit/sheet_update_cubit.dart';

class EquipmentsPage extends StatelessWidget {
  const EquipmentsPage(this.sheet, {super.key});

  final SheetModel sheet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Equipamento'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CardTitle(
            title: 'Bolsa',
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                mainAxisSpacing: 20,
                mainAxisExtent: 40,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: sheet.bag.toMap().entries.map((entry) {
                return TextFormFieldBottomSheet(
                  label: entry.key,
                  value: entry.value.toString(),
                  onFieldSubmitted: (value) {
                    context
                        .read<SheetUpdateCubit>()
                        .update(sheet.copyWith(bag: sheet.bag.copyWithMap({entry.key: entry.value})));
                  },
                );
              }).toList(),
            ),
          ),
          BlocProvider(
            create: (context) => sl<EquipmentBloc>(),
            child: Builder(
              builder: (context) {
                return Expanded(
                  child: CardTitle(
                    title: 'Equipamentos',
                    icon: InkWell(
                      child: const Icon(Icons.add),
                      onTap: () async {
                        final result = await context.pushNamed<EquipmentModel?>(Routes.equipmentForm.name);
                        if (result == null) return;

                        if (context.mounted) {
                          context.read<EquipmentBloc>().add(EquipmentCreateEvent(result));
                        }
                      },
                    ),
                    child: BlocBuilder<EquipmentBloc, EquipmentState>(
                      builder: (context, state) {
                        switch (state) {
                          case EquipmentStateLoaded():
                            return Expanded(
                              child: ListView.builder(
                                itemCount: state.equipments.length,
                                itemBuilder: (context, index) {
                                  final equipment = state.equipments[index];
                                  return Dismissible(
                                    key: ValueKey(equipment.id),
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
                                    onDismissed: (_) => context.read<EquipmentBloc>().add(
                                          EquipmentDeleteEvent(equipment.id),
                                        ),
                                    child: ListTile(
                                      title: Text(equipment.name),
                                      trailing: Text('${equipment.price} | ${equipment.weight}'),
                                      subtitle: Text(
                                        equipment.description,
                                        maxLines: 1,
                                        style: const TextStyle(overflow: TextOverflow.ellipsis),
                                      ),
                                      minLeadingWidth: 20,
                                      leading: const SizedBox(
                                        width: 20,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          child: Icon(Rpg.shield, size: 25, color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          case EquipmentStateEmpty():
                            return const Center(child: Text('Nenhum equipamento.'));
                          default:
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
