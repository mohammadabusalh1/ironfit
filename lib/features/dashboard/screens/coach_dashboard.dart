import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/widgets/coach_nav_bar.dart';
import 'package:ironfit/features/dashboard/controllers/coach_dashboard_controller.dart';
import 'package:ironfit/features/dashboard/widgets/coach_dashboard_body.dart';

class CoachDashboard extends StatelessWidget {
  final CoachDashboardController dashboardController =
      Get.put(CoachDashboardController());

  CoachDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CoachDashboardBody(),
      bottomNavigationBar: CoachNavBar(),
    );
  }
}
