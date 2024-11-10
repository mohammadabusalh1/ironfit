import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';
import 'package:ironfit/features/editPlan/widgets/BuildTextField.dart';

Widget BuildIconButton({
  String? text,
  IconData? icon,
  Widget? imageIcon,
  VoidCallback? onPressed,
  Color backgroundColor = Palette.mainAppColor,
  Color textColor = Palette.white,
  double width = 200,
  IconAlignment iconAlignment = IconAlignment.end,
  double fontSize = 16,
  double iconSize = 16,
  Color? iconColor = Palette.white,
  double height = 45,
}) {
  return icon != null
      ? ElevatedButton.icon(
          icon: imageIcon ??
              Icon(
                icon,
                size: iconSize,
                color: iconColor,
              ),
          onPressed: onPressed ?? () {},
          label: Opacity(opacity: 0.9, child: Text(text ?? '')),
          iconAlignment: iconAlignment,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: textColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            fixedSize: Size(width, height),
            textStyle: AppStyles.textCairoButton(fontSize),
          ),
        )
      : ElevatedButton(
          onPressed: onPressed ?? () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: textColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            fixedSize: Size(width, height),
            textStyle: AppStyles.textCairoButton(fontSize),
          ),
          child: Opacity(opacity: 0.9, child: Text(text ?? '')),
        );
}

Widget ReturnBackButton() {
  return Directionality(
      textDirection: dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
      child: ElevatedButton(
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
        child: Icon(
          dir == 'rtl' ? Icons.arrow_left : Icons.arrow_right,
          color: Palette.mainAppColor,
          size: 24,
        ),
      ));
}
