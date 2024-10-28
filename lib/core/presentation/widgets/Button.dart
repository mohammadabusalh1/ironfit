import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';

Widget BuildIconButton({
  required String text,
  IconData? icon,
  Widget? imageIcon,
  VoidCallback? onPressed,
  Color backgroundColor = Palette.mainAppColor,
  Color textColor = Palette.white,
  double width = double.infinity,
  IconAlignment iconAlignment = IconAlignment.end,
}) {
  return icon != null
      ? ElevatedButton.icon(
          icon: imageIcon ?? Icon(icon, size: 15),
          onPressed: onPressed ?? () {},
          label: Opacity(opacity: 0.9, child: Text(text)),
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
          child: Opacity(opacity: 0.9, child: Text(text)),
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: textColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            minimumSize: Size(width, 45),
            textStyle: AppStyles.textCairoButton(16),
          ),
        );
}
