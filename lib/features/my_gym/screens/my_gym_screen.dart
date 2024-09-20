import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presention/widgets/app_bar.dart';
import 'package:ironfit/core/presention/widgets/nav_bar.dart';
import 'package:ironfit/features/my_gym/controllers/my_gym_controller.dart';
import 'package:ironfit/features/my_gym/widgets/my_gym_body.dart';

class MyGymScreen extends StatelessWidget {
  final MyGymController controller = Get.put(MyGymController());

  MyGymScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'My Gym'),
      body: MyGymBody(),
      bottomNavigationBar: NavBar(),
    );
  }
}