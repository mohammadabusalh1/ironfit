import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presention/widgets/app_bar.dart';
import 'package:ironfit/core/presention/widgets/nav_bar.dart';
import 'package:ironfit/features/profile/controllers/profile_controller.dart';
import 'package:ironfit/features/profile/widgets/profile_body.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileController dashboardController = Get.put(ProfileController());

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Profile',
      ),
      body: const ProfileBody(),
      bottomNavigationBar: NavBar(),
    );
  }
}
