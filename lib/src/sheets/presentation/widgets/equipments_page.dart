import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/core/routes/routes_name.dart';
import 'package:repege/core/services/injection_container.dart';
import 'package:repege/core/widgets/card_title.dart';
import 'package:repege/src/equipments/data/models/equipment_model.dart';
import 'package:repege/src/equipments/domain/bloc/equipment_bloc.dart';
import 'package:repege/src/equipments/presentation/widgets/equipment_card.dart';
import 'package:repege/src/sheets/data/models/sheet_model.dart';
import 'package:repege/src/sheets/domain/cubit/sheet_update_cubit.dart';
import 'package:repege/src/sheets/presentation/widgets/currency_list.dart';

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
            child: CurrencyList(
              bag: sheet.bag,
              onChange: (bag) => context.read<SheetUpdateCubit>().update(sheet.copyWith(bag: bag)),
            ),
          ),
          BlocProvider(
            create: (context) {
              final bloc = sl<EquipmentBloc>();

              bloc.add(EquipmentInitEvent(sheet.id));

              return bloc;
            },
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
                          context.read<EquipmentBloc>().add(EquipmentCreateEvent(result.copyWith(sheetId: sheet.id)));
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
                                  return EquipmentCard(
                                    equipment: equipment,
                                    onDismissed: (_) {
                                      context.read<EquipmentBloc>().add(EquipmentDeleteEvent(equipment));
                                    },
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
