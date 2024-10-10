import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/custom_text_widget.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:ironfit/features/dashboard/screens/coach_dashboard.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Palette.black,
      shadowColor: Palette.mainAppColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const _DrawerHeader(), // Custom header widget
          _buildListTile(
            icon: Icons.settings,
            title: 'Settings',
            onTap: () {
              _handleSettingsTap(context);
            },
          ),
          _buildListTile(
            icon: Icons.logout,
            title: 'Logout',
            onTap: () {
              _handleLogoutTap();
            },
          ),
        ],
      ),
    );
  }

  // Builds a ListTile for the side menu
  Widget _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: CustomTextWidget(
        text: title,
        fontSize: 20,
      ),
      onTap: onTap,
    );
  }

  // Handles navigation for the Settings menu item
  void _handleSettingsTap(BuildContext context) {
    Get.back(); // Close the drawer
    Navigator.pushNamed(context, '/settings'); // Navigate to settings page
    Get.off(CoachDashboard()); // Optionally navigate to CoachDashboard
  }

  // Handles logout logic and navigation
  void _handleLogoutTap() {
    Get.toNamed(Routes.singUp); // Navigate to sign-up page
    // Add your logout logic here (e.g., clear user session)
  }
}

// Custom header widget for the drawer
class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DrawerHeader(
      decoration: BoxDecoration(
        color: Palette.mainAppColor,
      ),
      child: CustomTextWidget(
        text: 'IRONFIT',
        fontSize: 36,
        color: Palette.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
