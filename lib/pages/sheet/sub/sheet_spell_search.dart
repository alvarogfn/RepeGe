import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:repege/components/domains/sheets/list_spell_card.dart';
import 'package:repege/components/shared/loading.dart';
import 'package:repege/models/dnd/spell.dart';
import 'package:repege/utils/validations/required_validation.dart';
import 'package:repege/utils/validations/validations.dart';

class SheetSpellSearch extends StatefulWidget {
  const SheetSpellSearch({super.key});

  @override
  State<SheetSpellSearch> createState() => _SheetSpellSearchState();
}

class _SheetSpellSearchState extends State<SheetSpellSearch> {
  final _controller = TextEditingController(text: '');
  Future<List<Spell>> _spells = Future.value([]);

  Future<List<Spell>> _fetchSpell() async {
    final Uri api = Uri.parse(
      "https://dnd-spell.vercel.app/search/spells?s=${_controller.text}",
    );

    final response = await http.get(api);
    final List<dynamic> json = jsonDecode(response.body);

    return json
        .map((item) => Spell(
              level: SpellLevels.values.firstWhere(
                (l) => l.value == item['level'],
              ),
              type: SpellTypes.values.firstWhere(
                (t) {
                  return t.name.toLowerCase() ==
                      item['type'].toString().toLowerCase();
                },
              ),
              catalyts: List.from(item['components']).map((v) {
                return SpellCatalyts.values
                    .firstWhere((c) => c.abbreviation == v);
              }).toList(),
              castingTime: item['casting_time'],
              name: item['name'],
              description: item['description'],
              duration: item['duration'],
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buscar Magia"),
      ),
      body: Column(
        children: [
          searchTextField(),
          Expanded(
            child: FutureBuilder<List<Spell>>(
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

                  final List<Spell> spells = snapshot.data!;

                  if (spells.isEmpty) {
                    return const Center(
                      child: Text("Sem resultados."),
                    );
                  }

                  return ListView.builder(
                    itemCount: spells.length,
                    itemBuilder: (context, index) {
                      final Spell spell = spells[index];
                      return ListSpellCard(spell: spell);
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget searchTextField() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: "Buscar por nome, descrição, tipo, dano, efeito.",
        ),
        onFieldSubmitted: (_) {
          setState(() {
            _spells = _fetchSpell();
          });
        },
        validator: (value) => Validator.validateWith(value, [
          RequiredValidation(),
        ]),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
      ),
    );
  }
}
