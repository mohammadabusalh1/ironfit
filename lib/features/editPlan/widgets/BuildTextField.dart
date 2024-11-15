import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';

String dir = LocalizationService.getDir();

Widget BuildTextField({
  Function(String)? onChange,
  Function()? onTap,
  required String label,
  TextInputType? keyboardType,
  TextEditingController? controller,
  String? hint,
  IconData? icon,
  String? Function(String?)? validator,
  List<TextInputFormatter>? inputFormatters,
  bool obscureText = false, // Add validator function
}) {
  return Directionality(
    textDirection: dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
    child: TextFormField(
      obscureText: obscureText,
      textDirection: dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
      onTap: onTap ?? () {},
      inputFormatters: inputFormatters,
      controller: controller,
      onChanged: onChange ?? (value) {},
      keyboardType: keyboardType ?? TextInputType.text,
      style: const TextStyle(color: Palette.white, fontSize: 14),
      decoration: InputDecoration(
        prefixIcon: icon == null
            ? null
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(
                  icon,
                  color: Palette.mainAppColor,
                  size: 20,
                ),
              ),
        hintText: hint,
        hintStyle:
            const TextStyle(color: Palette.mainAppColorWhite, fontSize: 10),
        labelText: label,
        labelStyle:
            AppStyles.textCairo(11, Palette.mainAppColorWhite.withOpacity(0.9), FontWeight.bold),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            width: 1,
            color: Palette.mainAppColor.withOpacity(0.4),
          ),
        ),
      ),
      validator: validator, // Assign validator function here
    ),
  );
}
