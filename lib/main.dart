import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/controllers/coach_nav_bar_controller.dart';
import 'package:ironfit/core/presentation/controllers/sharedPreferences.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/NotificationService.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:ironfit/features/CoachStatistics/screens/coach_statistics_screen.dart';
import 'package:ironfit/features/MyPlans/screens/my_plans_screen.dart';
import 'package:ironfit/features/SelectEnterType/screens/select_enter_screen.dart';
import 'package:ironfit/features/SelectLanguage/screens/select_lang_screen.dart';
import 'package:ironfit/features/Trainees/screens/Trainees_screen.dart';
import 'package:ironfit/features/UserMyPlan/screens/user_my_plan_screen.dart';
import 'package:ironfit/features/coachEnteInfo/screens/coach_ente_info_screen.dart';
import 'package:ironfit/features/createPlan/screens/create_plan_screen.dart';
import 'package:ironfit/features/dashboard/controllers/coach_dashboard_controller.dart';
import 'package:ironfit/features/dashboard/screens/coach_dashboard.dart';
import 'package:ironfit/features/dashboard/screens/trainer_dashboard.dart';
import 'package:ironfit/features/myGyms/screens/my_gyms_screen.dart';
import 'package:ironfit/features/my_gym/screens/my_gym_screen.dart';
import 'package:ironfit/features/preLoginScreens/screens/pre_login_screen.dart';
import 'package:ironfit/features/coachProfile/screens/coach_profile_screen.dart';
import 'package:ironfit/features/regestraion/login/screens/login_screen.dart';
import 'package:ironfit/features/regestraion/register/screens/sing_up_screen.dart';
import 'package:ironfit/features/coachProfile/controllers/coach_profile_controller.dart';
import 'package:ironfit/features/userEnteInfo/screens/user_ente_info_screen.dart';
import 'package:ironfit/features/userProfile/screens/user_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  LocalizationService.load('ar');

  final notificationService = NotificationService();
  await notificationService.init();

  PreferencesService preferencesService = PreferencesService();
  SharedPreferences prefs = await preferencesService.getPreferences();
  FirebaseAuth user = FirebaseAuth.instance;

  if (user.currentUser != null) {
    if (user.currentUser!.uid.isNotEmpty && prefs.getBool('isCoach') == false) {
      // Save user ID for background tasks
      await prefs.setString('userId', user.currentUser!.uid);

      // Set up subscription notifications
      await notificationService
          .setupSubscriptionListener(user.currentUser!.uid);
    }
  }
  // This function is the entry point of the app.
  // It starts the app by running the MyApp widget.
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This function checks if the user has already seen the pre-login screen.
  // It saves this info in something called "shared preferences" (a place to store small data).
  // If the user has seen the pre-login screen, it returns the login route.
  // Otherwise, it returns the pre-login screen route.
  Future<String> _checkFirstTimeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasSeenPreLoginScreen =
        prefs.getBool('hasSeenPreLoginScreen') ?? false;

    if (hasSeenPreLoginScreen) {
      return Routes.singUp; // Direct to the login screen
    } else {
      return Routes.selectLanguage; // Direct to the pre-login screen
    }
  }

  String dir = LocalizationService.getDir();

  @override
  Widget build(BuildContext context) {
    // This "Get" package helps manage app navigation and state.
    // Here, we're preparing controllers for navigation and other features.
    Get.put(CoachNavController()); // Prepares the navigation bar controller
    Get.lazyPut(
        () => CoachDashboardController()); // Prepares the dashboard controller
    Get.lazyPut(
        () => CoachProfileController()); // Prepares the profile controller

    return FutureBuilder<String>(
      future:
          _checkFirstTimeUser(), // Call the function to check if the user is new
      builder: (context, snapshot) {
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
              textTheme: TextTheme(
                bodyLarge: AppStyles.textCairo(
                    16, Palette.mainAppColorWhite, FontWeight.w500),
                bodyMedium: AppStyles.textCairo(
                    14, Palette.mainAppColorWhite, FontWeight.w500),
                headlineLarge: AppStyles.textCairo(
                    24, Palette.mainAppColorWhite, FontWeight.w500),
              ),
              primaryColor: Palette.mainAppColor, // Main color theme
              scaffoldBackgroundColor: Palette.black, // Background color
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Palette.black, // Button background color
              ),
              appBarTheme: const AppBarTheme(
                backgroundColor: Palette.mainAppColor,
                titleTextStyle: TextStyle(color: Palette.black, fontSize: 20),
                iconTheme: IconThemeData(color: Palette.black),
              ),
            ),
            initialRoute: snapshot.data,
            getPages: [
              GetPage(
                  name: Routes.selectEnter,
                  page: () => Directionality(
                      textDirection:
                          dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
                      child: SelectEnterScreen())),
              GetPage(
                  name: Routes.selectLanguage,
                  page: () => Directionality(
                      textDirection:
                          dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
                      child: SelectLanguageScreen())),
              GetPage(
                  name: Routes.coachDashboard,
                  page: () => Directionality(
                      textDirection:
                          dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
                      child: CoachDashboard())),
              GetPage(
                  name: Routes.trainerDashboard,
                  page: () => Directionality(
                      textDirection:
                          dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
                      child: TrainerDashboard())),
              GetPage(
                  name: Routes.myGym,
                  page: () => Directionality(
                      textDirection:
                          dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
                      child: MyGymScreen())),
              GetPage(
                  name: Routes.coachProfile,
                  page: () => Directionality(
                      textDirection:
                          dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
                      child: CoachProfileScreen())), // Coach's profile
              GetPage(
                  name: Routes.singUp,
                  page: () => Directionality(
                      textDirection:
                          dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
                      child: SignUpScreen())), // Sign-up page
              GetPage(
                  name: Routes.singIn,
                  page: () => Directionality(
                      textDirection:
                          dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
                      child: LoginScreen())), // Login page
              GetPage(
                  name: Routes.trainees,
                  page: () => Directionality(
                      textDirection:
                          dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
                      child:
                          const TraineesScreen())), // Trainees screen// Trainees by age group
              GetPage(
                  name: Routes.myPlans,
                  page: () => Directionality(
                      textDirection:
                          dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
                      child:
                          const MyPlansScreen())), // My plans, // Plan screen// Coach info // User stats
              GetPage(
                  name: Routes.userMyPlan,
                  page: () => const UserMyPlanScreen()), // User's own plan
              GetPage(
                  name: Routes.preLoginScreens,
                  page: () => Directionality(
                      textDirection:
                          dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
                      child:
                          const PreLoginScreen())), // Pre-login screens// Plan exercises
              GetPage(
                  name: Routes.createPlan,
                  page: () => Directionality(
                      textDirection:
                          dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
                      child:
                          const CreatePlanScreen())), // Create a new plan // Trainee screen
              GetPage(
                  name: Routes.myGyms,
                  page: () => Directionality(
                      textDirection:
                          dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
                      child: const MyGymsScreen())), // My gyms screen
              GetPage(
                  name: Routes.coachStatistics,
                  page: () => Directionality(
                      textDirection:
                          dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
                      child: const CoachStatisticsScreen())),
              GetPage(
                  name: Routes.userProfile,
                  page: () => Directionality(
                      textDirection:
                          dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
                      child: UserProfileScreen())),
              // GetPage(
              //     name: Routes.coachEnterInfo,
              //     page: () => Directionality(
              //         textDirection:
              //             dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
              //         child: CoachEnterInfoScreen())),
              // GetPage(
              //     name: Routes.userEnterInfo,
              //     page: () => Directionality(
              //         textDirection:
              //             dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
              //         child: UserEnterInfoScreen())),
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
