import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorThemePicker extends StatelessWidget {
  final Color currentColor;
  final Function(Color) onColorSelected;

  const ColorThemePicker(
      {super.key, required this.currentColor, required this.onColorSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Color? color = await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: currentColor,
                onColorChanged: (color) => onColorSelected(color),
              ),
            ),
          ),
        );
        if (color != null) {
          onColorSelected(color);
        }
      },
      child: Container(
        width: 24,
        height: 24,
        color: currentColor,
      ),
    );
  }
}
