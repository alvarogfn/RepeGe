import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:repege/core/utils/validations/required_validation.dart';
import 'package:repege/core/utils/validations/validations.dart';
import 'package:repege/core/widgets/text_form_field_bottom_sheet.dart';

class LifeTracker extends StatefulWidget {
  const LifeTracker({
    required this.currentHp,
    required this.maxHp,
    required this.temporaryHp,
    required this.onChangeCurrentHp,
    required this.onChangeMaxHp,
    required this.onChangeTemporaryHp,
    super.key,
  });

  final int currentHp;
  final int maxHp;
  final int temporaryHp;
  final void Function(int newCurrentHp) onChangeCurrentHp;
  final void Function(int newMaxHp) onChangeMaxHp;
  final void Function(int newTemporaryHp) onChangeTemporaryHp;

  @override
  State<LifeTracker> createState() => _LifeTrackerState();
}

class _LifeTrackerState extends State<LifeTracker> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Vida', style: Theme.of(context).textTheme.labelLarge),
                PopupMenuButton(
                  child: GestureDetector(
                    child: const Icon(Icons.more_vert),
                  ),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: const Text('Descanso Longo'),
                        onTap: () {
                          widget.onChangeTemporaryHp(0);
                          widget.onChangeCurrentHp(widget.maxHp);
                        },
                      )
                    ];
                  },
                )
              ],
            ),
            const SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextFormFieldBottomSheet(
                  label: 'Temp',
                  value: widget.temporaryHp.toString(),
                  onFieldSubmitted: (value) => widget.onChangeTemporaryHp(int.parse(value)),
                  validator: (value) => Validator.validateWith(value, [RequiredValidation()]),
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                ),
                const SizedBox(width: 20),
                TextFormFieldBottomSheet(
                  label: 'Atual',
                  value: widget.currentHp.toInt().toString(),
                  onFieldSubmitted: (value) {
                    if (int.parse(value) >= widget.maxHp) {
                      return widget.onChangeCurrentHp(widget.maxHp);
                    }
                    widget.onChangeCurrentHp(int.parse(value));
                  },
                  validator: (value) => Validator.validateWith(value, [RequiredValidation()]),
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                ),
                Expanded(
                  child: Slider(
                    value: widget.currentHp.toDouble(),
                    max: widget.maxHp.toDouble(),
                    onChanged: (_) {
                      // setState(() => currentHp = newCurrentHp);
                    },
                    onChangeEnd: (newCurrentHp) => widget.onChangeCurrentHp(newCurrentHp.toInt()),
                    divisions: widget.maxHp > 0 ? widget.maxHp : 1,
                  ),
                ),
                TextFormFieldBottomSheet(
                  label: 'Max',
                  value: widget.maxHp.toString(),
                  onFieldSubmitted: (value) => widget.onChangeMaxHp(int.parse(value)),
                  validator: (value) => Validator.validateWith(value, [RequiredValidation()]),
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
