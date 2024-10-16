import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/widgets/PagesHeader.dart';
import 'package:ironfit/core/presentation/widgets/exersiceCarousel.dart';
import 'package:ironfit/features/dashboard/controllers/trainer_dashboard_controller.dart';
import 'package:ironfit/core/presentation/style/palette.dart';

class TrainerDashboardBody extends StatelessWidget {
  final TrainerDashboardController controller =
      Get.put(TrainerDashboardController());

  TrainerDashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.black,
      body: Column(
        children: [
          _buildDashboardHeader(),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildDashboardImage(context),
                  const SizedBox(height: 24),
                  _buildTodayExercisesButton(),
                  const SizedBox(height: 24),
                  ExerciseCarousel(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardHeader() {
    return const DashboardHeader(
      backgroundImage: Assets.dashboardBackground,
      trainerImage: Assets.myTrainerImage,
      trainerName: "محمد ابو صالح",
      trainerEmail: "oG2gU@example.com",
    );
  }

  Widget _buildDashboardImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Image.asset(
          Assets.dashboardYellow,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.23,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTodayExercisesButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        height: 40,
        decoration: BoxDecoration(
          color: Palette.secondaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Text(
          'تمارين اليوم',
          style: TextStyle(
              fontSize: 16, color: Palette.white, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
