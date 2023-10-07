import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/components/card_title.dart';
import 'package:repege/components/text_form_field_bottom_sheet.dart';
import 'package:repege/config/routes_name.dart';
import 'package:repege/modules/casting/services/spells_service.dart';
import 'package:repege/modules/sheet/sheet_service.dart';
import 'package:repege/modules/casting/models/casting.dart';
import 'package:repege/modules/sheets/components/spell_list_item.dart';
import 'package:repege/modules/sheets/services/sheet.dart';
import 'package:repege/modules/spell/models/spell.dart';

class CastingScreen extends StatefulWidget {
  const CastingScreen({super.key});

  @override
  State<CastingScreen> createState() => _CastingScreenState();
}

class _CastingScreenState extends State<CastingScreen> {
  Casting _casting = Casting();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final sheet = context.watch<Sheet>();
    _casting = sheet.casting;
  }

  Future addNewSpell(BuildContext context, Map<String, dynamic> data) {
    return context.read<SpellsService>().add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Magias'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Consumer2<Sheet, SheetService>(
            builder: (context, sheet, service, child) {
              return CardTitle(
                title: 'Atributos',
                icon: Text(sheet.character.characterClass),
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 20,
                    mainAxisExtent: 50,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    TextFormFieldBottomSheet(
                      label: 'Bonus de Ataque',
                      value: sheet.casting.attackBonus.toString(),
                      onChanged: (attackBonus) => _casting.attackBonus = int.tryParse(attackBonus) ?? 0,
                      onFieldSubmitted: (_) => service.update(_casting),
                    ),
                    TextFormFieldBottomSheet(
                      label: 'Hab. de Conjuração',
                      value: sheet.casting.castingHability.toString(),
                      onChanged: (castingHability) => _casting.castingHability = int.tryParse(castingHability) ?? 0,
                      onFieldSubmitted: (_) => service.update(_casting),
                    ),
                    TextFormFieldBottomSheet(
                      label: 'Res. Mágica',
                      value: sheet.casting.magicResistance.toString(),
                      onChanged: (magicResistance) => _casting.magicResistance = int.tryParse(magicResistance) ?? 0,
                      onFieldSubmitted: (_) => service.update(_casting),
                    ),
                  ],
                ),
              );
            },
          ),
          ChangeNotifierProxyProvider<Sheet, SpellsService>(
            create: (context) => SpellsService(context.read<Sheet>()),
            update: (context, sheet, service) {
              final sheet = context.read<Sheet>();

              if (service == null) return SpellsService(sheet);
              service.sheet = sheet;

              return service;
            },
            child: Expanded(
              child: CardTitle(
                title: 'Magias',
                icon: Consumer<SpellsService>(builder: (context, service, _) {
                  return PopupMenuButton(
                    child: const Icon(Icons.more_vert),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          child: const Text('Escrever Magia'),
                          onTap: () async {
                            final data = await context.pushNamed<Map<String, dynamic>>(RoutesName.spellsForm.name);
                            if (data == null) return;
                            service.add(data);
                          },
                        ),
                        // PopupMenuItem(
                        //   child: const Text('Buscar Magia'),
                        //   onTap: () => context.pushNamed(RoutesName.spellsSearch.name),
                        // )
                      ];
                    },
                  );
                }),
                child: StreamProvider<List<Spell>>(
                  initialData: const [],
                  create: (context) => context.read<SpellsService>().stream(),
                  builder: (context, _) {
                    final spells = context.watch<List<Spell>>();

                    if (spells.isEmpty) return const Text('Vazio');

                    return Expanded(
                      child: ListView.builder(
                        itemCount: spells.length,
                        itemBuilder: (context, index) {
                          return SpellListItem(spell: spells[index]);
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
