import 'package:flutter/material.dart';

class AttributesCard extends StatefulWidget {
  const AttributesCard({super.key});

  @override
  State<AttributesCard> createState() => _AttributesCardState();
}

class _AttributesCardState extends State<AttributesCard> {
  @override
  Widget build(BuildContext context) {
    return Text('');
    // return Card(
    //   child: Padding(
    //     padding: const EdgeInsets.all(10),
    //     child: Column(
    //       children: [
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Text(
    //               'Atributos',
    //               style: Theme.of(context).textTheme.labelLarge,
    //             ),
    //             Consumer<Sheet>(
    //               builder: (context, sheet, _) => GestureDetector(
    //                 onTap: () => showKeyboardBottomSheet(
    //                   context,
    //                   padding: const EdgeInsets.only(top: 10),
    //                   builder: (context) {
    //                     return SkillFloatingList(
    //                       attributes: sheet.attributes,
    //                       onChanged: (path, newValue) => sheet.ref.update({path: newValue}),
    //                     );
    //                   },
    //                 ),
    //                 child: const Icon(Icons.expand),
    //               ),
    //             )
    //           ],
    //         ),
    //         const SizedBox(height: 10),
    //         SizedBox(
    //           height: 100,
    //           child: Consumer<Sheet>(
    //             builder: (context, sheet, child) {
    //               return GridView(
    //                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //                   crossAxisCount: 3,
    //                   mainAxisSpacing: 20,
    //                   mainAxisExtent: 36,
    //                 ),
    //                 shrinkWrap: true,
    //                 physics: const NeverScrollableScrollPhysics(),
    //                 children: [
    //                   TitleFormFieldBottomSheet(
    //                     title: sheet.attributes.strength.modifier.toString(),
    //                     label: 'Força',
    //                     value: sheet.attributes.strength.value.toString(),
    //                     onFieldSubmitted: (value) => sheet.ref.update({
    //                       'attributes.strength.value': int.parse(value),
    //                     }),
    //                   ),
    //                   TitleFormFieldBottomSheet(
    //                     title: sheet.attributes.constitution.modifier.toString(),
    //                     label: 'Constituição',
    //                     value: sheet.attributes.constitution.value.toString(),
    //                     onFieldSubmitted: (value) => sheet.ref.update({
    //                       'attributes.constitution.value': int.parse(value),
    //                     }),
    //                   ),
    //                   TitleFormFieldBottomSheet(
    //                     title: sheet.attributes.dextery.modifier.toString(),
    //                     label: 'Destreza',
    //                     value: sheet.attributes.dextery.value.toString(),
    //                     onFieldSubmitted: (value) => sheet.ref.update({
    //                       'attributes.dextery.value': int.parse(value),
    //                     }),
    //                   ),
    //                   TitleFormFieldBottomSheet(
    //                     title: sheet.attributes.intelligence.modifier.toString(),
    //                     label: 'Inteligência',
    //                     value: sheet.attributes.intelligence.value.toString(),
    //                     onFieldSubmitted: (value) => sheet.ref.update({
    //                       'attributes.intelligence.value': int.parse(value),
    //                     }),
    //                   ),
    //                   TitleFormFieldBottomSheet(
    //                     title: sheet.attributes.wisdom.modifier.toString(),
    //                     label: 'Sabedoria',
    //                     value: sheet.attributes.wisdom.value.toString(),
    //                     onFieldSubmitted: (value) => sheet.ref.update({
    //                       'attributes.wisdom.value': int.parse(value),
    //                     }),
    //                   ),
    //                   TitleFormFieldBottomSheet(
    //                     title: sheet.attributes.charisma.modifier.toString(),
    //                     label: 'Carisma',
    //                     value: sheet.attributes.charisma.value.toString(),
    //                     onFieldSubmitted: (value) => sheet.ref.update({
    //                       'attributes.charisma.value': int.parse(value),
    //                     }),
    //                   ),
    //                 ],
    //               );
    //             },
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}
