import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';

Widget BuildTextField(
    {Function(String)? onChange,
    Function()? onTap,
    required String label,
    TextInputType? keyboardType,
    TextEditingController? controller,
    String? hint,
    IconData? icon,
    String? Function(String?)? validator,
    List<TextInputFormatter>? inputFormatters // Add validator function
    }) {
  return TextFormField(
    onTap: () => onTap!() ?? () {},
    inputFormatters: inputFormatters,
    controller: controller,
    onChanged: (value) => onChange!(value) ?? {},
    keyboardType: keyboardType ?? TextInputType.text,
    style: const TextStyle(color: Palette.white, fontSize: 14),
    decoration: InputDecoration(
      filled: true,
      fillColor: Palette.secondaryColor,
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
      labelStyle:
          AppStyles.textCairo(14, Palette.subTitleGrey, FontWeight.bold),
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
