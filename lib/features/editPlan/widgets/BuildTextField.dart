import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ironfit/core/presentation/style/palette.dart';

Widget BuildTextField({
  String? value,
  required Function(String) onChange,
  required String label,
  TextInputType? keyboardType, // Initial value parameter
}) {
  // Create a TextEditingController and set the initial value
  TextEditingController _controller = TextEditingController(text: value);

  return TextField(
    controller: _controller, // Assign the controller
    onChanged: (value) => onChange(value),
    keyboardType: keyboardType ?? TextInputType.text,
    style: const TextStyle(color: Palette.white, fontSize: 14),
    decoration: InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          width: 1,
          color: Palette.mainAppColor,
        ),
      ),
      labelStyle: const TextStyle(color: Palette.subTitleGrey, fontSize: 14),
    ),
  );
}
