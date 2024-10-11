import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/widgets/coach_nav_bar.dart';
import 'package:ironfit/features/CoachStatistics/widgets/coach_statistics_body.dart';

class CoachStatisticsScreen extends StatelessWidget {
  const CoachStatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const CoachStatisticsBody(),
      bottomNavigationBar: CoachNavBar(),
    );
  }
}
