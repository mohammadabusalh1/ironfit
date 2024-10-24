import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ironfit/core/presentation/style/palette.dart';

Widget BuildTextField({
  required Function(String) onChange,
  required String label,
  TextInputType? keyboardType,
  TextEditingController? controller, // Initial value parameter
}) {
  return TextField(
    controller: controller, // Assign the controller
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
