import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/style/palette.dart';

// CustomAppBar is a reusable widget that extends the AppBar.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title; // The title displayed on the AppBar.
  final List<Widget>?
      actions; // Optional list of action widgets (e.g., buttons) on the right side.
  final Widget?
      leading; // Optional leading widget (e.g., back button) on the left side.
  final Color backgroundColor; // Background color of the AppBar.
  final Color? shadowColor; // Optional shadow color for the AppBar.
  final double? shadowOpacity; // Optional shadow opacity.

  // Constructor for CustomAppBar with required and optional parameters.
  const CustomAppBar({
    super.key,
    required this.title, // Title is required.
    this.actions, // Actions are optional.
    this.leading, // Leading widget is optional.
    this.backgroundColor = Palette.mainAppColor, // Default background color.
    this.shadowColor, // Shadow color is optional.
    this.shadowOpacity = 0.4, // Default shadow opacity.
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              color: shadowColor?.withOpacity(shadowOpacity!) ??
                  Colors.black.withOpacity(0.4),
              blurRadius: 8.0,
              spreadRadius: 2.0,
              offset: const Offset(0, 2), // Shadow direction
            ),
          ],
        ),
        child: AnimatedOpacity(
          opacity: 1.0,
          duration:
              const Duration(milliseconds: 300), // Duration for fade effect
          child: AppBar(
            title: AnimatedDefaultTextStyle(
              style: const TextStyle(
                fontWeight: FontWeight.bold, // Bold font weight for the title.
                fontSize: 20.0, // Font size for the title.
                color: Colors.white, // Title text color
              ),
              duration: const Duration(
                  milliseconds: 300), // Animation duration for text style
              child: Text(title), // Title text displayed on the AppBar.
            ),
            leading: leading, // Leading widget (if provided).
            actions: actions, // List of action widgets (if provided).
            backgroundColor: Colors
                .transparent, // Make AppBar transparent to see the background.
            elevation: 0, // Remove default elevation to use custom shadow.
            centerTitle: true, // Center the title in the AppBar.
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(
      kToolbarHeight); // Define the preferred height of the AppBar.
}
