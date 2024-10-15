import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ironfit/core/presentation/controllers/nav_bar_controller.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:ironfit/features/CoachStatistics/screens/coach_statistics_screen.dart';
import 'package:ironfit/features/MyPlans/screens/my_plans_screen.dart';
import 'package:ironfit/features/Trainee/screens/trainee_screen.dart';
import 'package:ironfit/features/Trainees/screens/Trainees_screen.dart';
import 'package:ironfit/features/UserMyPlan/screens/user_my_plan_screen.dart';
import 'package:ironfit/features/UserPalnExercises/screens/user_plan_exercises_screen.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyD7c0gMFuZhSkiYZWcZxX6_EuUsrYicLPQ",
            authDomain: "ironfit-edef8.firebaseapp.com",
            projectId: "ironfit-edef8",
            storageBucket: "ironfit-edef8.appspot.com",
            messagingSenderId: "252100398371",
            appId: "1:252100398371:web:bc04fec736142df19cd096",
            measurementId: "G-5RB0H19GQF"));
  } else {
    await Firebase.initializeApp();
  }

  await GoogleSignIn(
    clientId:
        '741508899065-mqlsiob4n2jfvlrka1a44j8lovpnerq3.apps.googleusercontent.com',
  );

  // This function is the entry point of the app.
  // It starts the app by running the MyApp widget.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This function checks if the user has already seen the pre-login screen.
  // It saves this info in something called "shared preferences" (a place to store small data).
  // If the user has seen the pre-login screen, it returns the login route.
  // Otherwise, it returns the pre-login screen route.
  Future<String> _checkFirstTimeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasSeenPreLoginScreen =
        prefs.getBool('hasSeenPreLoginScreen') ?? false;

    if (hasSeenPreLoginScreen) {
      return Routes.singIn; // Direct to the login screen
    } else {
      return Routes.preLoginScreens; // Direct to the pre-login screen
    }
  }

  @override
  Widget build(BuildContext context) {
    // This "Get" package helps manage app navigation and state.
    // Here, we're preparing controllers for navigation and other features.
    Get.put(NavController()); // Prepares the navigation bar controller
    Get.lazyPut(
        () => CoachDashboardController()); // Prepares the dashboard controller
    Get.lazyPut(
        () => CoachProfileController()); // Prepares the profile controller

    // This widget decides what the app should display based on whether the user
    // has seen the pre-login screen or not.
    return FutureBuilder<String>(
      future:
          _checkFirstTimeUser(), // Call the function to check if the user is new
      builder: (context, snapshot) {
        // While the app is figuring out if the user has seen the pre-login screen,
        // it shows a loading animation.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                  child: CircularProgressIndicator()), // Shows loading spinner
            ),
          );
        }

        // Once the app knows where to start, it shows the correct screen (route).
        if (snapshot.hasData) {
          return GetMaterialApp(
            title: 'IronFit',
            debugShowCheckedModeBanner:
                false, // Hides the debug banner in the corner
            theme: ThemeData(
              primaryColor: Palette.mainAppColor, // Main color theme
              scaffoldBackgroundColor: Palette.black, // Background color
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Palette.black, // Button background color
              ),
              appBarTheme: const AppBarTheme(
                backgroundColor: Palette.mainAppColor, // App bar color
                titleTextStyle: TextStyle(
                    color: Palette.black, fontSize: 20), // Title style
                iconTheme: IconThemeData(color: Palette.black), // Icon color
              ),
            ),
            initialRoute: Routes
                .singIn, // Initial route (screen) the app will show
            getPages: [
              // Here we define different screens (pages) and routes for navigation.
              GetPage(
                  name: Routes.coachDashboard,
                  page: () => Directionality(
                      textDirection:
                          TextDirection.rtl, // RTL = Right to Left (Arabic)
                      child: CoachDashboard())), // Coach's dashboard page
              GetPage(
                  name: Routes.trainerDashboard,
                  page: () => Directionality(
                      textDirection: TextDirection.rtl,
                      child: TrainerDashboard())), // Trainer's dashboard
              GetPage(
                  name: Routes.myGym,
                  page: () => Directionality(
                      textDirection: TextDirection.rtl,
                      child: MyGymScreen())), // MyGym page
              GetPage(
                  name: Routes.coachProfile,
                  page: () => Directionality(
                      textDirection: TextDirection.rtl,
                      child: CoachProfileScreen())), // Coach's profile
              GetPage(
                  name: Routes.singUp,
                  page: () => const Directionality(
                      textDirection: TextDirection.rtl,
                      child: SignUpScreen())), // Sign-up page
              GetPage(
                  name: Routes.singIn,
                  page: () => const Directionality(
                      textDirection: TextDirection.rtl,
                      child: LoginScreen())), // Login page
              GetPage(
                  name: Routes.trainees,
                  page: () => const Directionality(
                      textDirection: TextDirection.rtl,
                      child: TraineesScreen())), // Trainees screen
              GetPage(
                  name: Routes.traineesGroupsByAge,
                  page: () =>
                      const TraineesGroupsByAgeScreen()), // Trainees by age group
              GetPage(
                  name: Routes.myPlans,
                  page: () => const Directionality(
                      textDirection: TextDirection.rtl,
                      child: MyPlansScreen())), // My plans
              GetPage(
                  name: Routes.plan,
                  page: () => const Directionality(
                      textDirection: TextDirection.rtl,
                      child: PlanScreen())), // Plan screen// Coach info
              GetPage(
                  name: Routes.userStatistics,
                  page: () => const Directionality(
                      textDirection: TextDirection.rtl,
                      child: UserStatisticsScreen())), // User stats
              GetPage(
                  name: Routes.userMyPlan,
                  page: () => const UserMyPlanScreen()), // User's own plan
              GetPage(
                  name: Routes.preLoginScreens,
                  page: () => const PreLoginScreen()), // Pre-login screens
              GetPage(
                  name: Routes.userPlanExercises,
                  page: () =>
                      const UserPalnExercisesScreen()), // Plan exercises
              GetPage(
                  name: Routes.createPlan,
                  page: () => const Directionality(
                      textDirection: TextDirection.rtl,
                      child: CreatePlanScreen())), // Create a new plan
              GetPage(
                  name: Routes.trainee,
                  page: () => const Directionality(
                      textDirection: TextDirection.rtl,
                      child: TraineeScreen())), // Trainee screen
              GetPage(
                  name: Routes.myGyms,
                  page: () => const Directionality(
                      textDirection: TextDirection.rtl,
                      child: MyGymsScreen())), // My gyms screen
              GetPage(
                  name: Routes.coachStatistics,
                  page: () => const Directionality(
                      textDirection: TextDirection.rtl,
                      child: CoachStatisticsScreen())),
            ],
          );
        } else {
          // If something goes wrong while loading, show an error message.
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: Text('Error loading app')), // Error message
            ),
          );
        }
      },
    );
  }
}
