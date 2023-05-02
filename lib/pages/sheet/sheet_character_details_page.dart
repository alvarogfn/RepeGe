import 'package:flutter/material.dart';
import 'package:repege/components/shared/circle_icon.dart';
import 'package:repege/components/shared/form/form_card_bottom_editable.dart';
import 'package:repege/components/shared/full_screen_scroll.dart';
import 'package:repege/models/dnd/sheets/sheet.dart';

class SheetCharacterDetailsPage extends StatefulWidget {
  const SheetCharacterDetailsPage({required this.sheet, super.key});

  final Sheet sheet;

  @override
  State<SheetCharacterDetailsPage> createState() =>
      _SheetCharacterDetailsPageState();
}

class _SheetCharacterDetailsPageState extends State<SheetCharacterDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return FullScreenScroll(
      child: Column(
        children: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [const PopupMenuItem(child: Text('hehe'))];
            },
            icon: const CircleIcon(
              width: 70,
              height: 70,
              icon: Icon(Icons.add),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: FormCardBottomEditable(
              title: "Informações Básicas:",
              fields: widget.sheet.fields(),
              onSaved: (values) => {
                widget.sheet.updateMany(values),
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CharacterPicture extends StatelessWidget {
  const CharacterPicture({required this.picture, this.onLongPress, super.key});

  final String picture;
  final void Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress,
      child: Container(
        height: 200,
        width: 150,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(50),
          image: DecorationImage(image: NetworkImage(picture)),
        ),
        child: const SizedBox(),
      ),
    );
  }
}
