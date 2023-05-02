import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/components/shared/circle_icon.dart';
import 'package:repege/components/shared/loading.dart';
import 'package:repege/components/shared/stack_floating_button.dart';
import 'package:repege/models/dnd/sheets/sheet.dart';
import 'package:repege/models/dnd/sheets/sheet_spells.dart';
import 'package:repege/models/dnd/spell.dart';
import 'package:repege/route.dart';

class SheetSpellsDetailsPage extends StatefulWidget {
  const SheetSpellsDetailsPage({required this.sheet, super.key});
  final Sheet sheet;

  @override
  State<SheetSpellsDetailsPage> createState() => _SheetSpellsDetailsPageState();
}

class _SheetSpellsDetailsPageState extends State<SheetSpellsDetailsPage> {
  Future<List<Spell>> spells = Future.value([]);

  SheetSpells get sheetSpells => widget.sheet.sheetSpells;

  Future<void> _refreshSpells() async {
    setState(() {
      spells = sheetSpells.fetch();
    });
  }

  @override
  void didUpdateWidget(covariant SheetSpellsDetailsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    _refreshSpells();
  }

  @override
  void initState() {
    super.initState();
    _refreshSpells();
  }

  Future<void> _addNewSpell(BuildContext context) async {
    Map<String, Object?>? spellData = await context.pushNamed(
      RoutesName.sheetSpellCreate.name,
      params: {'id': widget.sheet.id},
    );

    if (spellData == null) return;

    final spell = Spell.fromMap(spellData);

    sheetSpells.add(spell);
  }

  Future<void> _searchForSpell(BuildContext ontext) async {
    Spell? spell = await context.pushNamed(
      RoutesName.sheetSpellSearch.name,
      params: {'id': widget.sheet.id},
    );

    if (spell == null) return;

    sheetSpells.add(spell);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 100,
            width: double.infinity,
            child: Card(
              child: Text(
                sheetSpells.spellAttackBonus.toString(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "Lista de Magias",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          FutureBuilder<List<Spell>>(
            future: spells,
            builder: (context, snapshot) {
              if (snapshot.error != null) throw snapshot.error!;
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loading();
              }

              if (!snapshot.hasData) return const Loading();

              final spells = snapshot.data!;

              return Expanded(
                child: RefreshIndicator(
                  onRefresh: _refreshSpells,
                  child: ListView.builder(
                    itemCount: spells.length,
                    itemBuilder: (context, index) {
                      final Spell spell = spells[index];
                      return SpellListTile(spell);
                    },
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  ClipRRect floatingActionButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Material(
        child: PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              child: const Text('Preencher'),
              onTap: () => _addNewSpell(context),
            ),
            PopupMenuItem(
              child: const Text('Buscar'),
              onTap: () => _searchForSpell(context),
            ),
          ],
          child: const CircleIcon(
            height: 50,
            width: 50,
            backgroundColor: Colors.black,
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class SpellListTile extends StatelessWidget {
  const SpellListTile(
    this.spell, {
    super.key,
  });

  final Spell spell;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(spell.name),
        subtitle: Text(spell.description),
        leading: CircleAvatar(
          backgroundColor: spell.damageType?.color ?? Colors.grey,
          child: Text(spell.damageType?.name ?? 'Outro'),
        ),
        trailing: Text(
          "${spell.catalyts.map((e) => '${e.abbreviation},')} ${spell.castingTime}, ${spell.level.name}",
        ),
        isThreeLine: true,
      ),
    );
  }
}
