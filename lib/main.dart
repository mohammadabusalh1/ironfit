import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/controllers/coach_nav_bar_controller.dart';
import 'package:ironfit/core/presentation/controllers/sharedPreferences.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:ironfit/features/CoachStatistics/screens/coach_statistics_screen.dart';
import 'package:ironfit/features/MyPlans/screens/my_plans_screen.dart';
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
import 'package:ironfit/features/userEnteInfo/screens/user_ente_info_screen.dart';
import 'package:ironfit/features/userProfile/screens/user_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ironfit/features/userStatistics/screens/user_statistics_screen.dart';
import 'package:workmanager/workmanager.dart';

void checkSubscriptionExpiry(DateTime? endDate) {
  if (endDate == null) return;

  DateTime currentDate = DateTime.now();

  // If the subscription has ended
  if (currentDate.isAfter(endDate) || currentDate.compareTo(endDate) == 0) {
    sendNotification("إنتهى الاشتراك", "يرجى تجديد الاشتراك");
  }
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> sendNotification(String title, String body) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'subscription_channel', // Channel ID
    'Subscription Notifications', // Channel name
    channelDescription: 'Notifications for subscription expiry',
    importance: Importance.max,
    priority: Priority.high,
  );

  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0, // Notification ID
    title,
    body,
    platformChannelSpecifics,
    payload: 'Subscription Ended',
  );
}

void listenToSubscriptionChanges(String userId) async {
  DocumentSnapshot userSnapshot =
      await FirebaseFirestore.instance.collection('trainees').doc(userId).get();

  await FirebaseFirestore.instance
      .collection('coaches')
      .doc(userSnapshot.get('coachId'))
      .collection('subscriptions')
      .doc(userSnapshot.get('subscriptionId'))
      .snapshots()
      .listen((DocumentSnapshot snapshot) {
    if (snapshot.exists) {
      String endDateTimestamp = snapshot.get('subscriptionEndDate');
      DateTime endDate = DateTime.parse(endDateTimestamp);
      checkSubscriptionExpiry(endDate);
    }
  });
}

void callbackDispatcher(String userId) {
  Workmanager().executeTask((task, inputData) async {
    FirebaseFirestore.instance
        .collection('trainees')
        .doc(userId)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        String endDateTimestamp = snapshot.get('subscriptionEndDate');
        DateTime endDate = DateTime.parse(endDateTimestamp);
        checkSubscriptionExpiry(endDate);
      }
    });
    return Future.value(true);
  });
}

void scheduleDailyCheck() {
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  Workmanager().registerPeriodicTask(
    "subscription_check_task",
    "subscription_check_task",
    frequency: Duration(hours: 24), // Run once a day
  );
}

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

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Initialize notifications
  await initializeNotifications();

  scheduleDailyCheck();

  PreferencesService preferencesService = PreferencesService();
  SharedPreferences prefs = await preferencesService.getPreferences();
  FirebaseAuth user = FirebaseAuth.instance;
  if (user.currentUser != null) {
    if (user.currentUser!.uid.isNotEmpty && prefs.getBool('isCoach') == false) {
      // Start listening to subscription changes for a user
      listenToSubscriptionChanges(user.currentUser!.uid);
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
      return Routes.preLoginScreens; // Direct to the pre-login screen
    }
  }

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
            initialRoute: snapshot.data!,
            getPages: [
              GetPage(
                  name: Routes.coachDashboard,
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
                      child:
                          TraineesScreen())), // Trainees screen// Trainees by age group
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
                  page: () => Directionality(
                      textDirection: TextDirection.rtl,
                      child: const PreLoginScreen())), // Pre-login screens
              GetPage(
                  name: Routes.userPlanExercises,
                  page: () =>
                      const UserPalnExercisesScreen()), // Plan exercises
              GetPage(
                  name: Routes.createPlan,
                  page: () => const Directionality(
                      textDirection: TextDirection.rtl,
                      child:
                          CreatePlanScreen())), // Create a new plan // Trainee screen
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
              GetPage(
                  name: Routes.userProfile,
                  page: () => Directionality(
                      textDirection: TextDirection.rtl,
                      child: UserProfileScreen())),
              GetPage(
                  name: Routes.coachEnterInfo,
                  page: () => Directionality(
                      textDirection: TextDirection.rtl,
                      child: CoachEnterInfoScreen())),
              GetPage(
                  name: Routes.userEnterInfo,
                  page: () => Directionality(
                      textDirection: TextDirection.rtl,
                      child: UserEnterInfoScreen())),
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
