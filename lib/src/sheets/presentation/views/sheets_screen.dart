import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/core/routes/routes_name.dart';
import 'package:repege/core/services/injection_container.dart';
import 'package:repege/src/authentication/domain/cubit/authentication_cubit.dart';
import 'package:repege/src/miscellaneous/presentation/widgets/app_drawer.dart';
import 'package:repege/src/sheets/data/models/sheet_model.dart';
import 'package:repege/src/sheets/domain/bloc/sheet_list_bloc.dart';
import 'package:repege/src/sheets/presentation/widgets/sheet_list_item.dart';

class SheetsScreen extends StatelessWidget {
  const SheetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final sheetListBloc = sl<SheetListBloc>();

        final authState = context.read<AuthenticationCubit>().state;

        if (authState is Authenticated) {
          sheetListBloc.add(SheetListInitEvent(createdBy: authState.user.id));
        }

        return sheetListBloc;
      },
      child: Scaffold(
        drawer: const AppDrawer(),
        appBar: AppBar(
          title: const Text('Personagens'),
          actions: [
            Builder(builder: (context) {
              return IconButton(
                onPressed: () async {
                  final bloc = context.read<SheetListBloc>();
                  final state = context.read<AuthenticationCubit>().state;

                  final data = await context.pushNamed<SheetModel>(Routes.sheetCreate.name);

                  if (data == null) return;
                  if (state is Authenticated) bloc.add(SheetListAddEvent(sheet: data, user: state.user));
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
                        child: SheetListItem(
                          sheet: sheet,
                          onTap: () => context.pushNamed(Routes.sheet.name, pathParameters: {
                            'id': sheet.id,
                          }),
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
