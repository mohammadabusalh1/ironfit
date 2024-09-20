import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presention/style/palette.dart';
import 'package:ironfit/core/presention/widgets/custom_text_widget.dart';
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
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Palette.mainAppColor,
            ),
            child: CustomTextWidget(
              text: 'IRONFIT',
              fontSize: 36,
              color: Palette.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const CustomTextWidget(
              text: 'Settings',
              fontSize: 20,
            ),
            onTap: () {
              Get.back();
              Navigator.pushNamed(context, '/settings');
              Get.off(CoachDashboard());
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const CustomTextWidget(
              text: 'Logout',
              fontSize: 20,
            ),
            onTap: () {
              Get.back();
              // Handle logout logic
            },
          ),
        ],
      ),
    );
  }
}
