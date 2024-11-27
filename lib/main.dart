import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ironfit/config/EnvConfig.dart';
import 'package:ironfit/core/presentation/controllers/coach_nav_bar_controller.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:ironfit/core/services/notification_service.dart';
import 'package:ironfit/features/ChatScreen/ChatScreen.dart';
import 'package:ironfit/features/CoachStatistics/screens/coach_statistics_screen.dart';
import 'package:ironfit/features/MyPlans/screens/my_plans_screen.dart';
import 'package:ironfit/features/SelectEnterType/screens/select_enter_screen.dart';
import 'package:ironfit/features/SelectLanguage/screens/select_lang_screen.dart';
import 'package:ironfit/features/Trainees/screens/Trainees_screen.dart';
import 'package:ironfit/features/UserMyPlan/screens/user_my_plan_screen.dart';
import 'package:ironfit/features/coachProfile/controllers/coach_profile_controller.dart';
import 'package:ironfit/features/createPlan/screens/create_plan_screen.dart';
import 'package:ironfit/features/dashboard/screens/coach_dashboard.dart';
import 'package:ironfit/features/dashboard/screens/trainer_dashboard.dart';
import 'package:ironfit/features/myGyms/screens/my_gyms_screen.dart';
import 'package:ironfit/features/my_gym/screens/my_gym_screen.dart';
import 'package:ironfit/features/preLoginScreens/screens/pre_login_screen.dart';
import 'package:ironfit/features/coachProfile/screens/coach_profile_screen.dart';
import 'package:ironfit/features/regestraion/login/screens/login_screen.dart';
import 'package:ironfit/features/regestraion/register/screens/sing_up_screen.dart';
import 'package:ironfit/features/userProfile/screens/user_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize();
  MobileAds.instance.initialize();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: EnvConfig.firebaseApiKey,
        authDomain: EnvConfig.firebaseAuthDomain,
        projectId: EnvConfig.firebaseProjectId,
        storageBucket: EnvConfig.firebaseStorageBucket,
        messagingSenderId: EnvConfig.firebaseMessagingSenderId,
        appId: EnvConfig.firebaseAppId,
        measurementId: EnvConfig.firebaseMeasurementId,
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  NotificationService.checkPendingNotifications();
  LocalizationService.load('ar');
  Connectivity()
      .onConnectivityChanged
      .listen((List<ConnectivityResult> results) {
    print('aaa');
    if (!results.contains(ConnectivityResult.none)) {
      NotificationService.checkPendingNotifications();
    }
  });

  // This function is the entry point of the app.
  // It starts the app by running the MyApp widget.
  runApp(RestartWidget());
}

class RestartWidget extends StatefulWidget {
  RestartWidget({Key? key}) : super(key: key);

  static void restartApp(BuildContext context) {
    final _RestartWidgetState? state =
        context.findAncestorStateOfType<_RestartWidgetState>();
    state?.restartApp(); // Adding a null check here
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  // This function checks if the user has already seen the pre-login screen.
  // It saves this info in something called "shared preferences" (a place to store small data).
  // If the user has seen the pre-login screen, it returns the login route.
  // Otherwise, it returns the pre-login screen route.
  Future<String> _checkFirstTimeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasSeenPreLoginScreen =
        prefs.getBool('hasSeenPreLoginScreen') ?? false;

    if (hasSeenPreLoginScreen) {
      return Routes.selectEnter; // Direct to the login screen
    } else {
      return Routes.selectLanguage; // Direct to the pre-login screen
    }
  }

  String dir = LocalizationService.getDir();

  void restartApp() {
    setState(() {
      dir = LocalizationService.getDir();
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.put(
        CoachNavController()); // Prepares the navigation bar controller // Prepares the dashboard controller
    Get.lazyPut(
        () => CoachProfileController()); // Prepares the profile controller
    return KeyedSubtree(
      child: StreamBuilder<List<ConnectivityResult>>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.contains(ConnectivityResult.none)) {
            return MaterialApp(
              home: Scaffold(
                backgroundColor: Colors.black,
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.wifi_off, size: 64, color: Colors.white),
                      SizedBox(height: 16),
                      Text(
                        LocalizationService.translateFromGeneral('noInternetConnection'),
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return FutureBuilder<String>(
            future:
                _checkFirstTimeUser(), // Call the function to check if the user is new
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Directionality(
                  textDirection:
                      dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
                  child: GetMaterialApp(
                    title: 'IronFit',
                    debugShowCheckedModeBanner:
                        false, // Hides the debug banner in the corner
                    theme: ThemeData(
                      scaffoldBackgroundColor: Colors.black, // Background color
                    ),
                    initialRoute: snapshot.data,
                    getPages: [
                      GetPage(
                        name: Routes.selectEnter,
                        page: () => Directionality(
                          textDirection:
                              dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
                          child: const SelectEnterScreen(),
                        ),
                      ),
                      GetPage(
                        name: Routes.selectLanguage,
                        page: () => Directionality(
                          textDirection:
                              dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
                          child: const SelectLanguageScreen(),
                        ),
                      ),
                      GetPage(
                        name: Routes.coachDashboard,
                        page: () => Directionality(
                          textDirection:
                              dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
                          child: CoachDashboard(),
                        ),
                      ),
                      GetPage(
                        name: Routes.trainerDashboard,
                        page: () => Directionality(
                          textDirection:
                              dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
                          child: TrainerDashboard(),
                        ),
                      ),
                      GetPage(
                        name: Routes.myGym,
                        page: () => Directionality(
                          textDirection:
                              dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
                          child: MyGymScreen(),
                        ),
                      ),
                      GetPage(
                        name: Routes.coachProfile,
                        page: () => Directionality(
                          textDirection:
                              dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
                          child: CoachProfileScreen(),
                        ),
                      ),
                      GetPage(
                        name: Routes.singUp,
                        page: () => Directionality(
                          textDirection:
                              dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
                          child: const SignUpScreen(),
                        ),
                      ),
                      GetPage(
                        name: Routes.singIn,
                        page: () => Directionality(
                          textDirection:
                              dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
                          child: const LoginScreen(),
                        ),
                      ),
                      GetPage(
                        name: Routes.trainees,
                        page: () => Directionality(
                          textDirection:
                              dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
                          child: const TraineesScreen(),
                        ),
                      ),
                      GetPage(
                        name: Routes.myPlans,
                        page: () => Directionality(
                          textDirection:
                              dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
                          child: const MyPlansScreen(),
                        ),
                      ),
                      GetPage(
                        name: Routes.userMyPlan,
                        page: () => Directionality(
                          textDirection:
                              dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
                          child: const UserMyPlanScreen(),
                        ),
                      ),
                      GetPage(
                        name: Routes.preLoginScreens,
                        page: () => Directionality(
                          textDirection:
                              dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
                          child: const PreLoginScreen(),
                        ),
                      ),
                      GetPage(
                        name: Routes.createPlan,
                        page: () => Directionality(
                          textDirection:
                              dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
                          child: const CreatePlanScreen(),
                        ),
                      ),
                      GetPage(
                        name: Routes.myGyms,
                        page: () => Directionality(
                          textDirection:
                              dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
                          child: const MyGymsScreen(),
                        ),
                      ),
                      GetPage(
                        name: Routes.coachStatistics,
                        page: () => Directionality(
                          textDirection:
                              dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
                          child: const CoachStatisticsScreen(),
                        ),
                      ),
                      GetPage(
                        name: Routes.userProfile,
                        page: () => Directionality(
                          textDirection:
                              dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
                          child: UserProfileScreen(),
                        ),
                      ),
                      GetPage(
                        name: Routes.chat,
                        page: () => Directionality(
                          textDirection:
                              dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
                          child: const ChatScreen(),
                        ),
                      ),
                    ],
                  ),
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
        },
      ),
    );
  }
}
