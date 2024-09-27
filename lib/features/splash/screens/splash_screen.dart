import 'package:flutter/material.dart';
import 'package:ironfit/core/presention/style/palette.dart';
import 'package:ironfit/features/splash/widgets/splash_body.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
       backgroundColor: Palette.mainAppColor,
      body: SplashBody(),
    );
  }
}
