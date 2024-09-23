import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presention/controllers/nav_bar_controller.dart';
import 'package:ironfit/core/presention/style/palette.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:ironfit/features/Trainee/screens/trainee_screen.dart';
import 'package:ironfit/features/dashboard/screens/coach_dashboard.dart';
import 'package:ironfit/features/my_gym/screens/my_gym_screen.dart';
import 'package:ironfit/features/Trainees/screens/Trainees_screen.dart';
import 'package:ironfit/features/preLoginScreens/screens/pre_login_screen.dart';
import 'package:ironfit/features/regestraion/login/screens/login_screen.dart';
import 'package:ironfit/features/regestraion/register/screens/sing_up_screen.dart';
import 'package:ironfit/features/traineesGroupsbyAge/screens/trainees_groups_by_age_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NavController());
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
      initialRoute: Routes.trainee,
      getPages: [
        GetPage(name: Routes.home, page: () => CoachDashboard()),
        GetPage(name: Routes.myGym, page: () => MyGymScreen()),
        GetPage(name: Routes.singUp, page: () => const SignUpScreen()),
        GetPage(name: Routes.login, page: () => const LoginScreen()),
        GetPage(name: Routes.preLogin, page: () => const PreLoginScreen()),
        GetPage(name: Routes.trainees, page: () => const TraineesScreen()),
        GetPage(name: Routes.traineesGroupsByAge, page: () => TraineesGroupsByAgeScreen()),
        GetPage(name: Routes.trainee, page: () => const TraineeScreen()),
      ],
    );

  }
}
