import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/core/routes/routes_name.dart';
import 'package:repege/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:repege/src/sheets/domain/usecase/delete_sheet.dart';
import 'package:repege/src/sheets/domain/usecase/stream_all_sheets.dart';
import 'package:repege/src/sheets/presentation/cubit/sheets_cubit.dart';

class SheetsScreen extends StatefulWidget {
  const SheetsScreen({super.key});

  @override
  State<SheetsScreen> createState() => _SheetsScreenState();
}

class _SheetsScreenState extends State<SheetsScreen> {
  StreamSubscription? subscription;

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthenticationCubit>().state;
    final sheetsCubit = context.read<SheetsCubit>();

    if (authState is Authenticated) {
      subscription = sheetsCubit.streamAllSheets(StreamAllSheetsParams(createdBy: authState.user.id));
    }
  }

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personagens'),
        actions: [
          IconButton(
            onPressed: () => context.push(Routes.sheetCreate.name),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: BlocConsumer<SheetsCubit, SheetsState>(
        listener: (context, state) {
          if (state is SheetsDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Deletando...'),
              ),
            );
          }
        },
        builder: (context, state) {
          switch (state) {
            case SheetsList():
              return ListView.builder(
                itemCount: state.sheets.length,
                itemBuilder: (context, index) {
                  final sheet = state.sheets[index];

                  return SizedBox(
                    height: 80,
                    child: Card(
                      child: Dismissible(
                        key: ValueKey<String>(sheet.id),
                        onDismissed: (_) {
                          context.read<SheetsCubit>().deleteSheet(DeleteSheetParams(id: sheet.id));
                        },
                        confirmDismiss: (_) {
                          return showDialog<bool>(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  'Tem certeza que deseja deletar a ficha ${sheet.characterName}?',
                                ),
                                content: const Text('Essa ação é irreversível.'),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () => context.pop(true),
                                    child: const Text('Excluir'),
                                  )
                                ],
                              );
                            },
                          );
                        },
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          decoration: const BoxDecoration(color: Colors.red),
                          child: const Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Icon(Icons.delete),
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            context.pushNamed(Routes.sheet.name, pathParameters: {
                              'id': sheet.id,
                            });
                          },
                          child: Expanded(
                            child: ListTile(
                              title: Text(sheet.characterName),
                              subtitle: Text(
                                '${sheet.characterRace}, ${sheet.characterClass}, ${sheet.alignment}.',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
