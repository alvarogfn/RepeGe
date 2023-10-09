import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/core/routes/routes_name.dart';
import 'package:repege/core/services/injection_container.dart';
import 'package:repege/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:repege/src/miscellaneous/presentation/widgets/app_drawer.dart';
import 'package:repege/src/sheets/domain/usecase/create_sheet.dart';
import 'package:repege/src/sheets/domain/usecase/delete_sheet.dart';
import 'package:repege/src/sheets/domain/usecase/stream_all_sheets.dart';
import 'package:repege/src/sheets/presentation/cubit/sheet_list_cubit.dart';
import 'package:repege/src/sheets/presentation/cubit/sheets_cubit.dart';
import 'package:repege/src/sheets/presentation/widgets/show_text_snackbar.dart';

class SheetsScreen extends StatelessWidget {
  const SheetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<SheetListCubit>()),
        BlocProvider(create: (context) => sl<SheetsCubit>()),
      ],
      child: const _SheetsScreen(),
    );
  }
}

class _SheetsScreen extends StatefulWidget {
  const _SheetsScreen();

  @override
  State<_SheetsScreen> createState() => __SheetsScreenState();
}

class __SheetsScreenState extends State<_SheetsScreen> {
  StreamSubscription? subscription;

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthenticationCubit>().state;
    final sheetsCubit = context.read<SheetListCubit>();

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
    return BlocListener<SheetsCubit, SheetsState>(
      listener: (context, state) {
        if (state is SheetsError) {
          showTextSnackbar(context, state.message);
        } else if (state is SheetsCreated) {
          showTextSnackbar(context, state.sheet.characterName);
        } else if (state is SheetsDeleted) {
          showTextSnackbar(context, 'DELETADO');
        }
      },
      child: Scaffold(
        drawer: const AppDrawer(),
        appBar: AppBar(
          title: const Text('Personagens'),
          actions: [
            Builder(builder: (context) {
              return IconButton(
                onPressed: () async {
                  final createSheet = context.read<SheetsCubit>().createSheet;

                  final data = await context.pushNamed<CreateSheetParams>(Routes.sheetCreate.name);

                  if (data == null) return;

                  await createSheet(data);

                  if (context.mounted) {
                    // context.pushNamed(Routes.sheet.name, pathParameters: {'id': state.sheet.id});
                  }
                },
                icon: const Icon(Icons.add),
              );
            })
          ],
        ),
        body: BlocBuilder<SheetListCubit, SheetListState>(
          builder: (context, state) {
            switch (state) {
              case SheetListEmpty():
                return const Center(child: Text('Nenhum personagem criado.'));
              case SheetListLoading():
                return const Center(child: CircularProgressIndicator());
              case SheetListLoaded():
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
                                    'Tem certeza que deseja deletar a ficha //${sheet.characterName}?',
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
                            onTap: () => context.pushNamed(Routes.sheet.name, pathParameters: {
                              'id': sheet.id,
                            }),
                            child: ListTile(
                              title: Text(sheet.characterName),
                              subtitle: Text(
                                '${sheet.characterRace}, ${sheet.characterClass}, ${sheet.alignment}.',
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
            }
          },
        ),
      ),
    );
  }
}
