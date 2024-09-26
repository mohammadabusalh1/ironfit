import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presention/controllers/nav_bar_controller.dart';
import 'package:ironfit/core/presention/style/palette.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:ironfit/features/dashboard/controllers/coach_dashboard_controller.dart';
import 'package:ironfit/features/dashboard/screens/coach_dashboard.dart';
import 'package:ironfit/features/dashboard/screens/trainer_dashboard.dart';
import 'package:ironfit/features/my_gym/screens/my_gym_screen.dart';
import 'package:ironfit/features/profile/screens/profile_screen.dart';
import 'package:ironfit/features/regestraion/register/screens/sing_up_screen.dart';
import 'package:ironfit/features/profile/controllers/profile_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NavController());
    Get.lazyPut(() => CoachDashboardController());
    Get.lazyPut(() => ProfileController());

    return GetMaterialApp(
      title: 'IronFit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Palette.mainAppColor,
        scaffoldBackgroundColor: Palette.black,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Palette.black,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Palette.mainAppColor,
          titleTextStyle: TextStyle(color: Palette.black, fontSize: 20),
          iconTheme: IconThemeData(color: Palette.black),
        ),
      ),
      initialRoute: Routes.home,
      getPages: [
        GetPage(name: Routes.home, page: () => CoachDashboard()),
        GetPage(name: Routes.dashboard, page: () => TrainerDashboard()),
        GetPage(name: Routes.myGym, page: () => MyGymScreen()),
        GetPage(name: Routes.profile, page: () => ProfileScreen()),
        GetPage(name: Routes.singUp, page: () => const SignUpScreen()),
      ],
    );
  }
}
