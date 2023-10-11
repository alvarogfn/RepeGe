import 'package:flutter/material.dart';
import 'package:repege/components/loading.dart';
import 'package:repege/modules/casting/services/spells_service.dart';
import 'package:repege/modules/spell/components/spell_card_item.dart';
import 'package:repege/modules/spell/components/spell_search_field.dart';
import 'package:repege/modules/spell/models/spell.dart';

class SpellSearchScreen extends StatefulWidget {
  const SpellSearchScreen({
    super.key,
  });

  @override
  State<SpellSearchScreen> createState() => _SpellSearchScreenState();
}

class _SpellSearchScreenState extends State<SpellSearchScreen> {
  Future<List<Spell>> _spells = Future.value([]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buscar Magia')),
      body: Column(
        children: [
          SpellSearchField(
            onFieldSubmitted: (value) => setState(() {
              _spells = SpellsService.fromDnDBook(value);
            }),
          ),
          Expanded(
            child: FutureBuilder<List<Spell>>(
              future: _spells,
              initialData: const [],
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Loading();
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Não foi possível buscar. ${snapshot.error.toString()}',
                    ),
                  );
                }

                final List<Spell> spells = snapshot.data!;

                if (spells.isEmpty) {
                  return const Center(child: Text('Sem resultados.'));
                }

                return ListView.builder(
                  itemCount: spells.length,
                  itemBuilder: (context, index) {
                    final Spell spell = spells[index];
                    return SpellCardItem(spell: spell);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
