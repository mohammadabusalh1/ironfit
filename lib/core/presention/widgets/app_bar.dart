import 'package:flutter/material.dart';
import 'package:ironfit/core/presention/style/palette.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final Color backgroundColor;

  const CustomAppBar({super.key,
    required this.title,
    this.actions,
    this.leading,
    this.backgroundColor = Palette.mainAppColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
      leading: leading,
      actions: actions,
      backgroundColor: backgroundColor,
      elevation: 6.0,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
