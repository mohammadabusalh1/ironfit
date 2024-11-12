import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/widgets/coach_nav_bar.dart';
import 'package:ironfit/features/dashboard/widgets/coach_dashboard_body.dart';

class CoachDashboard extends StatelessWidget {

  CoachDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CoachDashboardBody(),
      bottomNavigationBar: CoachNavBar(),
    );
  }
}
