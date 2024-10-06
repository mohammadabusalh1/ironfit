import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presention/widgets/coach_nav_bar.dart';
import 'package:ironfit/features/coachProfile/controllers/coach_profile_controller.dart';
import 'package:ironfit/features/coachProfile/widgets/coach_profile_body.dart';

class CoachProfileScreen extends StatelessWidget {
  final CoachProfileController dashboardController = Get.put(CoachProfileController());

  CoachProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const CoachProfileBody(),
      bottomNavigationBar: CoachNavBar(),
    );
  }
}
