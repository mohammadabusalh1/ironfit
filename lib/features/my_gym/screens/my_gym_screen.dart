import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/widgets/coach_nav_bar.dart';
import 'package:ironfit/features/coachEnteInfo/controllers/coach_ente_info_controller.dart';
import 'package:ironfit/features/my_gym/widgets/my_gym_body.dart';

class MyGymScreen extends StatelessWidget {
  final MyGymController controller = Get.put(MyGymController());

  MyGymScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const MyGymBody(),
      bottomNavigationBar: CoachNavBar(),
    );
  }
}
