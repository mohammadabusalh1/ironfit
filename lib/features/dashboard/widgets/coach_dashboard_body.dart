import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presention/style/assets.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:ironfit/features/dashboard/widgets/card_widget.dart';
import 'package:ironfit/features/dashboard/controllers/coach_dashboard_controller.dart';


class CoachDashboardBody extends StatelessWidget {
  final CoachDashboardController dashboardController = Get.find();
  final CoachDashboardController controller = Get.put(CoachDashboardController());
  CoachDashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(children: [
        const SizedBox(height: 40,),
        CardWidget(
          onTap: () => Get.toNamed(Routes.myGym),
          title: 'My Gym',
          subtitle: '',
          imagePath: Assets.myGymImage,
          description: '',
        ),
        const SizedBox(height: 40,),
        CardWidget(
          onTap: () => controller.onTap,
          title: 'My Trainers',
          imagePath: Assets.myTrainerImage,
          subtitle: ' ',
          description: '',
        ),
      ]),
    );
  }
}
