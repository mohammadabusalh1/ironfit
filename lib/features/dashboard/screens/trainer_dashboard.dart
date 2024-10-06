import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presention/widgets/app_bar.dart';
import 'package:ironfit/core/presention/widgets/side_menu.dart';
import 'package:ironfit/features/dashboard/controllers/trainer_dashboard_controller.dart';

import 'package:ironfit/core/presention/widgets/coach_nav_bar.dart';
import 'package:ironfit/features/dashboard/widgets/trainer_dashboard_body.dart';

class TrainerDashboard extends StatelessWidget {
  final TranierDashboardController dashboardController =
  Get.put(TranierDashboardController());

  TrainerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const CustomAppBar(title: 'Dashboard',),
      // drawer: const SideMenu(),
      body: TrainerDashboardBody(),
    );
  }
}
