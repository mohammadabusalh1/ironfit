import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presention/style/assets.dart';
import 'package:ironfit/core/presention/style/palette.dart';
import 'package:ironfit/core/presention/widgets/custom_text_widget.dart';
import 'package:ironfit/domain/enteites/coach.dart';
import 'package:ironfit/features/dashboard/controllers/coach_dashboard_controller.dart';
import 'package:ironfit/features/my_gym/widgets/coachs_list.dart';
import 'package:ironfit/features/my_gym/widgets/gym_ticket.dart';

class MyGymBody extends StatelessWidget {
  final CoachDashboardController dashboardController = Get.find();

  MyGymBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            GymTicket(
              name: 'Wider Gym',
              address: 'Bethlehem',
              imagePath: Assets.myGymImage,
              description: 'Where bodies change',
              onTap: () => dashboardController.onTap(),
            ),
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.topLeft,
              child: const CustomTextWidget(
                text: 'My Gym Coaches : ',
                color: Palette.mainAppColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 7),
            CoachList(
              coaches: [
                Coach(
                  name: 'Qossay Kamel',
                  imagePath: 'assets/coaches/john_doe.jpg',
                  description: 'Expert in fitness training.',
                  address: 'Bethlehem',
                ),
                Coach(
                  name: 'Mohammed Abu Saleh',
                  imagePath: 'assets/coaches/jane_smith.jpg',
                  description: 'Specialist in kathlaniks',
                  address: 'Surif',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
