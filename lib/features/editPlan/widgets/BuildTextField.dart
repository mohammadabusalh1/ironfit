import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/style/palette.dart';

Widget BuildTextField({
  required Function(String) onChange,
  required String label,
  TextInputType? keyboardType,
  TextEditingController? controller,
  String? hint,
  IconData? icon,
  String? Function(String?)? validator, // Add validator function
}) {
  return TextFormField(
    controller: controller,
    onChanged: (value) => onChange(value),
    keyboardType: keyboardType ?? TextInputType.text,
    style: const TextStyle(color: Palette.white, fontSize: 14),
    decoration: InputDecoration(
      prefixIcon: icon == null
          ? null
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                icon,
                color: Palette.gray,
                size: 20,
              ),
            ),
      hintText: hint,
      hintStyle: const TextStyle(color: Palette.gray, fontSize: 14),
      labelText: label,
      labelStyle: const TextStyle(color: Palette.subTitleGrey, fontSize: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          width: 1,
          color: Palette.mainAppColor,
        ),
      ),
    ),
    validator: validator, // Assign validator function here
  );
}
