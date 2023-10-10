import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/core/routes/routes_name.dart';
import 'package:repege/src/authentication/domain/cubit/authentication_cubit.dart';
import 'package:repege/src/miscellaneous/presentation/widgets/app_drawer.dart';
import 'package:repege/src/sheets/domain/bloc/sheet_list_bloc.dart';

class SheetsScreen extends StatefulWidget {
  const SheetsScreen({super.key});

  @override
  State<SheetsScreen> createState() => _SheetsScreenState();
}

class _SheetsScreenState extends State<SheetsScreen> {
  @override
  void initState() {
    super.initState();
    final state = context.read<AuthenticationCubit>().state;
    if (state is Authenticated) {
      context.read<SheetListBloc>().add(SheetListInitEvent(state.user.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Personagens'),
        actions: [
          Builder(builder: (context) {
            return IconButton(
              onPressed: () async {
                final createSheet = context.read<SheetListBloc>();
                final state = context.read<AuthenticationCubit>().state;

                final data = await context.pushNamed<SheetListAddEvent>(Routes.sheetCreate.name);

                if (data == null) return;
                if (state is Authenticated) {
                  createSheet.add(data);

                  if (context.mounted) {
                    // context.pushNamed(Routes.sheet.name, pathParameters: {'id': state.sheet.id});
                  }
                }
              },
              icon: const Icon(Icons.add),
            );
          })
        ],
      ),
      body: BlocBuilder<SheetListBloc, SheetListState>(
        builder: (context, state) {
          switch (state) {
            case SheetListLoadError():
              return const Center(child: Text('paia'));
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
                          context.read<SheetListBloc>().add(SheetListRemoveEvent(sheet.id));
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
    );
  }
}
