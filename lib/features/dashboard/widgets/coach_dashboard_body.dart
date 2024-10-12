import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/widgets/PagesHeader.dart';
import 'package:ironfit/core/presentation/widgets/StatisticsCard.dart';
import 'package:ironfit/features/dashboard/widgets/card_widget.dart';
import 'package:ironfit/features/dashboard/controllers/coach_dashboard_controller.dart';
import 'package:ironfit/core/routes/routes.dart';

class CoachDashboardBody extends StatelessWidget {
  final CoachDashboardController controller =
      Get.put(CoachDashboardController());

  CoachDashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDashboardHeader(),
        const SizedBox(height: 24),
        Container(
          height: MediaQuery.of(context).size.height * 0.63,
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildStatisticsRow(context),
                const SizedBox(height: 24),
                _buildCardWidget(
                  onTap: () => Get.toNamed(Routes.myGyms),
                  subtitle: 'الصالات الرياضية الخاص بي',
                  imagePath: Assets.myGymImage,
                  description: 'أضف معلومات النادي الرياضي الخاص بك',
                ),
                const SizedBox(height: 24),
                _buildCardWidget(
                  onTap: () => Get.toNamed(Routes.trainees),
                  subtitle: 'المتدربين',
                  imagePath: Assets.myTrainerImage,
                  description: 'أضف معلومات المتدربين الخاصين بك',
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDashboardHeader() {
    return const DashboardHeader(
      backgroundImage: Assets.dashboardBackground, // Background image path
      trainerImage: Assets.myTrainerImage, // Trainer image path
      trainerName: "محمد ابو صالح", // Trainer's name
      trainerEmail: "oG2gU@example.com", // Trainer's email
    );
  }

  Widget _buildStatisticsRow(BuildContext context) {
    return Row(
      children: [
        _buildStatisticsCard("30", "متدرب", context),
        const Spacer(), // Adjusted for consistent spacing
        _buildStatisticsCard("+30%", "الإشتراك", context),
      ],
    );
  }

  Widget _buildStatisticsCard(
      String subTitle, String title, BuildContext context) {
    return StatisticsCard(
      cardSubTitle: subTitle,
      cardTitle: title,
      width: MediaQuery.of(context).size.width * 0.4,
      height: 90,
    );
  }

  Widget _buildCardWidget({
    required void Function() onTap,
    required String subtitle,
    required String imagePath,
    required String description,
  }) {
    return CardWidget(
      onTap: onTap,
      subtitle: subtitle,
      imagePath: imagePath,
      description: description,
    );
  }
}
