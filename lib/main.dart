import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presention/controllers/nav_bar_controller.dart';
import 'package:ironfit/core/presention/style/palette.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:ironfit/features/MyPlans/screens/my_plans_screen.dart';
import 'package:ironfit/features/Trainee/screens/trainee_screen.dart';
import 'package:ironfit/features/Trainees/screens/Trainees_screen.dart';
import 'package:ironfit/features/UserMyPlan/screens/user_my_plan_screen.dart';
import 'package:ironfit/features/UserPalnExercises/screens/user_plan_exercises_screen.dart';
import 'package:ironfit/features/coachEnteInfo/screens/coach_ente_info_screen.dart';
import 'package:ironfit/features/createPlan/screens/create_plan_screen.dart';
import 'package:ironfit/features/dashboard/controllers/coach_dashboard_controller.dart';
import 'package:ironfit/features/dashboard/screens/coach_dashboard.dart';
import 'package:ironfit/features/dashboard/screens/trainer_dashboard.dart';
import 'package:ironfit/features/myGyms/screens/my_gyms_screen.dart';
import 'package:ironfit/features/my_gym/screens/my_gym_screen.dart';
import 'package:ironfit/features/plan/screens/plan_screen.dart';
import 'package:ironfit/features/preLoginScreens/screens/pre_login_screen.dart';
import 'package:ironfit/features/coachProfile/screens/coach_profile_screen.dart';
import 'package:ironfit/features/regestraion/login/screens/login_screen.dart';
import 'package:ironfit/features/regestraion/register/screens/sing_up_screen.dart';
import 'package:ironfit/features/coachProfile/controllers/coach_profile_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ironfit/features/traineesGroupsbyAge/screens/trainees_groups_by_age_screen.dart';
import 'package:ironfit/features/userStatistics/screens/user_statistics_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<String> _checkFirstTimeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasSeenPreLoginScreen =
        prefs.getBool('hasSeenPreLoginScreen') ?? false;

    if (hasSeenPreLoginScreen) {
      return Routes.singIn;
    } else {
      return Routes.preLoginScreens;
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(NavController());
    Get.lazyPut(() => CoachDashboardController());
    Get.lazyPut(() => CoachProfileController());

    return FutureBuilder<String>(
      future: _checkFirstTimeUser(), // Check if pre-login has been shown
      builder: (context, snapshot) {
        // While loading the decision, show a loading screen (or splash)
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                  child: CircularProgressIndicator()), // Loading indicator
            ),
          );
        }

        // Once the decision is ready, show the appropriate initial route
        if (snapshot.hasData) {
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
            // initialRoute: snapshot.data, // Dynamically set the initial route
            initialRoute: Routes.myGyms, // Dynamically set the initial route
            getPages: [
              GetPage(
                  name: Routes.home,
                  page: () => Directionality(
                      textDirection: TextDirection.rtl,
                      child: CoachDashboard())),
              GetPage(
                  name: Routes.trainerDashboard,
                  page: () => Directionality(
                      textDirection: TextDirection.rtl,
                      child: TrainerDashboard())),
              GetPage(
                  name: Routes.myGym,
                  page: () => Directionality(
                      textDirection: TextDirection.rtl, child: MyGymScreen())),
              GetPage(
                  name: Routes.profile,
                  page: () => Directionality(
                      textDirection: TextDirection.rtl,
                      child: CoachProfileScreen())),
              GetPage(
                  name: Routes.singUp,
                  page: () => const Directionality(
                      textDirection: TextDirection.rtl, child: SignUpScreen())),
              GetPage(
                  name: Routes.singIn,
                  page: () => const Directionality(
                      textDirection: TextDirection.rtl, child: LoginScreen())),
              GetPage(
                  name: Routes.trainees,
                  page: () => const Directionality(
                      textDirection: TextDirection.rtl,
                      child: TraineesScreen())),
              GetPage(
                  name: Routes.traineesGroupsByAge,
                  page: () => const TraineesGroupsByAgeScreen()),
              GetPage(
                  name: Routes.myPlans,
                  page: () => const Directionality(
                      textDirection: TextDirection.rtl,
                      child: MyPlansScreen())),
              GetPage(
                  name: Routes.plan,
                  page: () => const Directionality(
                      textDirection: TextDirection.rtl, child: PlanScreen())),
              GetPage(
                  name: Routes.coachEnteInfo,
                  page: () => Directionality(
                      textDirection: TextDirection.rtl,
                      child: CoachEnterInfoScreen())),
              GetPage(
                  name: Routes.userStatistics,
                  page: () => const Directionality(
                      textDirection: TextDirection.rtl,
                      child: UserStatisticsScreen())),
              GetPage(
                  name: Routes.userMyPlan,
                  page: () => const UserMyPlanScreen()),
              GetPage(
                  name: Routes.preLoginScreens,
                  page: () => const PreLoginScreen()),
              GetPage(
                  name: Routes.userPlanExercises,
                  page: () => const UserPalnExercisesScreen()),
              GetPage(
                  name: Routes.createPlan,
                  page: () => const Directionality(
                      textDirection: TextDirection.rtl,
                      child: CreatePlanScreen())),
              GetPage(
                  name: Routes.trainee,
                  page: () => const Directionality(
                      textDirection: TextDirection.rtl,
                      child: TraineeScreen())),
              GetPage(
                  name: Routes.myGyms,
                  page: () => const Directionality(
                      textDirection: TextDirection.rtl,
                      child: MyGymsScreen())),
            ],
          );
        } else {
          // In case something goes wrong, fallback to a safe screen
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: Text('Error loading app')),
            ),
          );
        }
      },
    );
  }
}
