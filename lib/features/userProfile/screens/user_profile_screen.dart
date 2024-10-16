import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/widgets/user_nav_bar.dart';
import 'package:ironfit/features/userProfile/controllers/user_profile_controller.dart';
import 'package:ironfit/features/userProfile/widgets/user_profile_body.dart';

class UserProfileScreen extends StatelessWidget {
  final UserProfileController dashboardController = Get.put(UserProfileController());

  UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const UserProfileBody(),
      bottomNavigationBar: UserNavBar(),
    );
  }
}
