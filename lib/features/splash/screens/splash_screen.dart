import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/features/splash/controllers/splash_controller.dart';
import 'package:ironfit/features/splash/widgets/splash_body.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final SplashController splashController = Get.put(SplashController());

    return const Scaffold(
      backgroundColor: Palette.mainAppColor,
      body: SplashBody(),
    );
  }
}
