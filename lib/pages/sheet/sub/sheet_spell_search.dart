import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/components/atoms/loading.dart';
import 'package:repege/components/molecules/input_search_bar.dart';
import 'package:repege/components/organism/list_spell_card.dart';
import 'package:repege/models/dnd/spell.dart';
import 'package:repege/icons/octicons_icons.dart';
import 'package:repege/services/spells_service.dart';

class SheetSpellSearch extends StatefulWidget {
  const SheetSpellSearch({super.key});

  @override
  State<SheetSpellSearch> createState() => _SheetSpellSearchState();
}

class _SheetSpellSearchState extends State<SheetSpellSearch> {
  final _controller = TextEditingController(text: '');
  Future<List<SpellModel>> _spells = Future.value([]);

  Future<List<SpellModel>> _fetchSpell() async {
    return SpellService.getBookSpells(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: [
          InputSearchBar(
            padding: const EdgeInsets.all(10),
            hint: "Buscar por nome, descrição, tipo, dano, efeito.",
            label: "",
            controller: _controller,
            onSubmit: (_) => setState(() {
              _spells = _fetchSpell();
            }),
          ),
          Expanded(
            child: FutureBuilder<List<SpellModel>>(
              future: _spells,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Loading();
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Não foi possível buscar. ${snapshot.error.toString()}",
                    ),
                  );
                }

                final List<SpellModel> spells = snapshot.data!;

                if (spells.isEmpty) {
                  return const Center(child: Text("Sem resultados."));
                }

                return ListView.builder(
                  itemCount: spells.length,
                  itemBuilder: (context, index) {
                    final SpellModel spell = spells[index];
                    return ListSpellCard(
                      spell: spell,
                      onPress: (spell) => context.pop(spell),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text("Buscar Magia"),
      actions: const [
        IconButton(
          onPressed: null,
          icon: Icon(Octicons.search),
          tooltip: 'Busca avançada',
        )
      ],
    );
  }
}
