import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
          const _DrawerHeader(),
          _buildListTile(
            icon: Icons.settings,
            title: 'الإعدادات',
            onTap: () {
              _handleSettingsTap(context);
            },
          ),
          _buildListTile(
            icon: Icons.logout,
            title: 'تسجيل الخروج',
            onTap: () {
              _handleLogoutTap(context);
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
      leading: Icon(icon, color: Colors.white),
      title: CustomTextWidget(
        text: title,
        fontSize: 20,
        color: Colors.white,
      ),
      onTap: onTap,
    );
  }

  // Handles navigation for the Settings menu item
  void _handleSettingsTap(BuildContext context) {
    Get.back(); // Close the drawer
    Get.off(CoachDashboard());
  }


  Future<void> _handleLogoutTap(BuildContext context) async {
    try {
      // Sign out the user from Firebase
      await FirebaseAuth.instance.signOut();

      Get.offAllNamed(Routes.singUp);

      Get.snackbar('تسجيل الخروج', 'تم تسجيل خروجك بنجاح.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } catch (e) {
      // Show error if something goes wrong during logout
      Get.snackbar('خطأ', 'فشل تسجيل الخروج: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
}

// Custom header widget for the drawer
class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({super.key});

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
