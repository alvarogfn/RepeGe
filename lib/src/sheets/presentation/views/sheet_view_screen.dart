import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repege/core/services/injection_container.dart';
import 'package:repege/src/sheets/domain/bloc/sheet_bloc.dart';

class SheetViewScreen extends StatelessWidget {
  const SheetViewScreen(this.sheetId, {super.key});

  final String sheetId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = sl<SheetBloc>();
        bloc.add(SheetInitEvent(sheetId));
        return bloc;
      },
      child: BlocBuilder<SheetBloc, SheetState>(
        builder: (context, state) {
          switch (state) {
            case SheetLoaded():
              final sheet = state.sheet;
              return Scaffold(
                appBar: AppBar(
                  title: Text(sheet.characterName),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(2.5),
                  child: Column(
                    children: [
                      Field(title: 'Classe', value: sheet.characterClass),
                      Field(title: 'Nível', value: sheet.characterRace),
                      Field(title: 'Level', value: sheet.characterLevel.toString()),
                      Field(title: 'Antepassado', value: sheet.background),
                      Field(title: 'Alinhamento', value: sheet.alignment),
                      Field(title: 'Linguas', value: sheet.languages),
                      Field(title: 'Classe de Armadura', value: sheet.armorClass.toString()),
                    ],
                  ),
                ),
              );
            case SheetError():
              return const Center(
                child: Text('Não foi possível carregar os participantes.'),
              );
            case SheetLoading():
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }
}

class Field extends StatelessWidget {
  const Field({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    if (value.isEmpty) return const SizedBox();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 10),
            Text(value),
          ],
        ),
      ),
    );
  }
}
