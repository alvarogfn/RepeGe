import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/core/services/injection_container.dart';
import 'package:repege/src/sheets/domain/bloc/sheet_list_bloc.dart';

class SheetSelectScreen extends StatelessWidget {
  const SheetSelectScreen({required this.createdBy, super.key});

  final String createdBy;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = sl<SheetListBloc>();
        bloc.add(SheetListInitEvent(createdBy));
        return bloc;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<SheetListBloc, SheetListState>(
          builder: (context, state) {
            return ListView.builder(
              itemBuilder: (context, index) {
                switch (state) {
                  case SheetListLoading():
                    return const Center(child: CircularProgressIndicator());
                  case SheetListLoaded():
                    return ListView.builder(
                        itemCount: state.sheets.length,
                        itemBuilder: (context, index) {
                          final sheet = state.sheets[index];
                          return ListTile(
                            onTap: () => context.pop(sheet),
                            title: Text(sheet.characterName),
                            subtitle: Text(
                              '${sheet.characterRace}, ${sheet.characterClass}, ${sheet.alignment}.',
                            ),
                          );
                        });
                  default:
                    return const Center(child: Text('Não foi possível carregar'));
                }
              },
            );
          },
        ),
      ),
    );
  }
}
