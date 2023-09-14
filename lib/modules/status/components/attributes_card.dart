import 'package:flutter/material.dart';
import 'package:repege/components/full_screen_scroll.dart';
import 'package:repege/helpers/show_keyboard_bottom_sheet.dart';

class AttributesCard extends StatelessWidget {
  const AttributesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Atributos',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                GestureDetector(
                  onTap: () => showKeyboardBottomSheet(
                    context,
                    padding: EdgeInsets.only(top: 10),
                    builder: (context) {
                      return SizedBox(
                        height: 500,
                        child: FullScreenScroll(
                          child: Column(
                            children: List.filled(
                              20,
                              CheckboxMenuButton(
                                value: true,
                                onChanged: (value) {},
                                child: Text('Força'),
                              ),
                            ).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                  child: const Icon(Icons.expand),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: TextFormField()),
                Expanded(child: TextFormField()),
                Expanded(
                  child: TextFormField(),
                )
              ],
            ),
            Row(
              children: [
                Expanded(child: TextFormField()),
                Expanded(child: TextFormField()),
                Expanded(child: TextFormField())
              ],
            ),
          ],
        ),
      ),
    );
  }
}
