import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presention/widgets/app_bar.dart';
import 'package:ironfit/core/presention/widgets/side_menu.dart';
import 'package:ironfit/features/dashboard/controllers/coach_dashboard_controller.dart';
import 'package:ironfit/features/dashboard/widgets/coach_dashboard_body.dart';
import 'package:ironfit/core/presention/widgets/nav_bar.dart';

class CoachDashboard extends StatelessWidget {
  final CoachDashboardController dashboardController =
      Get.put(CoachDashboardController());

  CoachDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Coach Dashboard',),
      drawer: const SideMenu(),
      body: CoachDashboardBody(),
      bottomNavigationBar:  NavBar(),
    );
  }
}
