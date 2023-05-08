import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/components/atoms/headline.dart';
import 'package:repege/components/atoms/input.dart';
import 'package:repege/components/layout/full_screen_scroll.dart';
import 'package:repege/components/organism/avatar_wallpaper.dart';
import 'package:repege/icons/rpg_icons.dart';
import 'package:repege/models/dnd/sheets/sheet.dart';
import 'package:repege/utils/validations/required_validation.dart';

class SheetCreatePage extends StatefulWidget {
  const SheetCreatePage({super.key});

  @override
  State<SheetCreatePage> createState() => _SheetCreatePageState();
}

class _SheetCreatePageState extends State<SheetCreatePage> {
  final SheetModel _sheet = SheetModel();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return _Layout(
      appBar: appBar(),
      formKey: _formKey,
      children: [
        AvatarWallpaper(
          image: _sheet.avatar,
          onChanged: (file) => setState(() => _sheet.avatarFile = file),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
          child: Column(
            children: [
              title("Dados Básicos"),
              Input(
                label: "Nome",
                placeholder: "Gandalf",
                margin: const EdgeInsets.symmetric(vertical: 7.5),
                onChanged: (value) => _sheet.characterName = value ?? '',
                prefixIcon: Rpg.helmet,
                validations: [RequiredValidation()],
                action: TextInputAction.next,
              ),
              Input(
                label: "Classe",
                placeholder: "Mago",
                onChanged: (value) => _sheet.characterClass = value ?? '',
                prefixIcon: Rpg.crossed_swords,
                margin: const EdgeInsets.symmetric(vertical: 7.5),
                validations: [RequiredValidation()],
                action: TextInputAction.next,
              ),
              Input(
                label: "Raça",
                placeholder: "Humano",
                onChanged: (value) => _sheet.characterRace = value ?? '',
                prefixIcon: Rpg.player,
                margin: const EdgeInsets.symmetric(vertical: 7.5),
                validations: [RequiredValidation()],
                action: TextInputAction.next,
              ),
              Input(
                label: "Antepassado",
                placeholder: "Eremita",
                onChanged: (value) => _sheet.background = value ?? '',
                prefixIcon: Rpg.dead_tree,
                margin: const EdgeInsets.symmetric(vertical: 7.5),
                validations: [RequiredValidation()],
                action: TextInputAction.next,
              ),
              Input(
                label: "Alinhamento",
                placeholder: "Neutro/Bom",
                onChanged: (value) => _sheet.alignment = value ?? '',
                prefixIcon: Rpg.player_pyromaniac,
                margin: const EdgeInsets.symmetric(vertical: 7.5),
                validations: [RequiredValidation()],
                action: TextInputAction.done,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container title(String text) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 20, bottom: 10),
      child: Headline(
        text: text,
        fontSize: 22,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text('Novo Personagem'),
      actions: [
        IconButton(
          onPressed: () {
            final isValid = _formKey.currentState?.validate();
            if (isValid == true) context.pop<SheetModel>(_sheet);
          },
          icon: const Icon(Icons.save),
        )
      ],
    );
  }
}

class _Layout extends StatelessWidget {
  const _Layout({
    required this.children,
    required this.formKey,
    required this.appBar,
  });

  final AppBar appBar;
  final GlobalKey<FormState> formKey;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: FullScreenScroll(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Form(
          key: formKey,
          child: Column(
            children: children,
          ),
        ),
      ),
    );
  }
}
