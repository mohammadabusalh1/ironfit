import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/widgets/user_nav_bar.dart';
import 'package:ironfit/features/dashboard/controllers/trainer_dashboard_controller.dart';
import 'package:ironfit/features/dashboard/widgets/trainer_dashboard_body.dart';

class TrainerDashboard extends StatelessWidget {
  final TrainerDashboardController dashboardController =
  Get.put(TrainerDashboardController());

  TrainerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TrainerDashboardBody(),
      bottomNavigationBar: UserNavBar(),
    );
  }
}
