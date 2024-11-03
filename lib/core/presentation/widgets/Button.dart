import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';

Widget BuildIconButton({
  String? text,
  IconData? icon,
  Widget? imageIcon,
  VoidCallback? onPressed,
  Color backgroundColor = Palette.mainAppColor,
  Color textColor = Palette.white,
  double width = double.infinity,
  IconAlignment iconAlignment = IconAlignment.end,
  double fontSize = 16,
  double iconSize = 16,
}) {
  return icon != null
      ? ElevatedButton.icon(
          icon: imageIcon ?? Icon(icon, size: iconSize),
          onPressed: onPressed ?? () {},
          label: Opacity(opacity: 0.9, child: Text(text ?? '')),
          iconAlignment: iconAlignment,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: textColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            minimumSize: Size(width, 45),
            textStyle: AppStyles.textCairoButton(16),
          ),
        )
      : ElevatedButton(
          onPressed: onPressed ?? () {},
          child: Opacity(opacity: 0.9, child: Text(text ?? '')),
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: textColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            minimumSize: Size(width, 45),
            textStyle: AppStyles.textCairoButton(fontSize),
          ),
        );
}

Widget ReturnBackButton() {
  return ElevatedButton(
    onPressed: () {
      Get.back();
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF1C1503),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      elevation: 0,
    ),
    child: const Icon(
      Icons.arrow_left,
      color: Color(0xFFFFBB02),
      size: 24,
    ),
  );
}
