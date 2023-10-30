import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/core/services/injection_container.dart';
import 'package:repege/src/sheets/domain/bloc/sheet_list_bloc.dart';
import 'package:repege/src/sheets/presentation/widgets/sheet_list_item.dart';

class SheetSelectScreen extends StatelessWidget {
  const SheetSelectScreen(this.createdBy, {super.key});

  final String createdBy;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = sl<SheetListBloc>();
        bloc.add(SheetListInitEvent(createdBy: createdBy));
        return bloc;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Selecione um personagem'),
        ),
        body: BlocBuilder<SheetListBloc, SheetListState>(
          builder: (context, state) {
            switch (state) {
              case SheetListLoading():
                return const Center(child: CircularProgressIndicator());
              case SheetListLoaded():
                return ListView.builder(
                    itemCount: state.sheets.length,
                    itemBuilder: (context, index) {
                      final sheet = state.sheets[index];
                      return SheetListItem(
                        sheet: sheet,
                        onTap: () => context.pop(state.sheets[index]),
                      );
                    });
              case SheetListEmpty():
                return const Center(
                  child: Text(
                    'Você ainda não criou nenhuma ficha.\n É preciso selecionar a ficha para entrar em uma campanha.',
                    textAlign: TextAlign.center,
                  ),
                );
              case SheetListLoadError():
                return const Center(child: Text('Não foi possível carregar'));
            }
          },
        ),
      ),
    );
  }
}
