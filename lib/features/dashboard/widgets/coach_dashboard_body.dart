import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presention/style/assets.dart';
import 'package:ironfit/core/presention/widgets/PagesHeader.dart';
import 'package:ironfit/core/presention/widgets/StatisticsCard.dart';
import 'package:ironfit/core/presention/widgets/custom_text_widget.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:ironfit/features/dashboard/widgets/card_widget.dart';
import 'package:ironfit/features/dashboard/controllers/coach_dashboard_controller.dart';

class CoachDashboardBody extends StatelessWidget {
  final CoachDashboardController dashboardController = Get.find();
  final CoachDashboardController controller =
      Get.put(CoachDashboardController());
  CoachDashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Expanded(
        child: SingleChildScrollView(
          child: Column(children: [
            const DashboardHeader(
              backgroundImage:
                  Assets.dashboardBackground, // Background image path
              trainerImage: Assets.myTrainerImage, // Trainer image path
              trainerName: "محمد ابو صالح", // Trainer's name
              trainerEmail: "oG2gU@example.com", // Trainer's email
            ),
            const SizedBox(height: 24),
            Row(children: [
              StatisticsCard(
                  cardSubTitle: "30",
                  cardTitle: "متدرب",
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 90),
              SizedBox(width: MediaQuery.of(context).size.width * 0.06),
              StatisticsCard(
                  cardSubTitle: "+30%",
                  cardTitle: "الإشتراك",
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 90),
            ]),
            const SizedBox(height: 24),
            CardWidget(
              onTap: () => Get.toNamed(Routes.myGyms),
              subtitle: 'الصالات الرياضية الخاص بي',
              imagePath: Assets.myGymImage,
              description: 'أضف معلومات النادي الرياضي الخاص بك',
            ),
            const SizedBox(
              height: 24,
            ),
            CardWidget(
              onTap: () => Get.toNamed(Routes.trainees),
              imagePath: Assets.myTrainerImage,
              subtitle: 'المتدربين',
              description: 'أضف معلومات المتدربين الخاصين بك',
            ),
            const SizedBox(height: 40),
          ]),
        ),
      ),
    );
  }
}
