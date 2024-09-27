import 'package:flutter/material.dart';
import 'package:ironfit/features/MyPlans/screens/my_plans_screen.dart';
import 'package:ironfit/features/dashboard/screens/coach_dashboard.dart';
import 'package:ironfit/features/enteInfo/screens/ente_info_screen.dart';
import 'package:ironfit/features/my_gym/screens/my_gym_screen.dart';
import 'package:ironfit/features/Trainees/screens/Trainees_screen.dart';
import 'package:ironfit/features/plan/screens/plan_screen.dart';
import 'package:ironfit/features/preLoginScreens/screens/pre_login_screen.dart';
import 'package:ironfit/features/regestraion/login/screens/login_screen.dart';
import 'package:ironfit/features/regestraion/register/screens/sing_up_screen.dart';
import 'package:ironfit/features/splash/screens/splash_screen.dart';
import 'package:ironfit/features/traineesGroupsbyAge/screens/trainees_groups_by_age_screen.dart';
import 'package:ironfit/features/userStatistics/screens/user_statistics_screen.dart';

class Routes {
  static const String home = '/';
  static const String coachDashboard = '/coachDashboard';
  static const String dashboard = '/trainerDashboard';
  static const String myGym = '/gymScreen';
  static const String profile = '/profileScreen';  // Add profile route
  static const String singUp = '/singUpScreen';
  static const String singIn = '/singInScreen';
  static const String login = '/singInScreen';
  static const String preLogin = '/preLoginScreen';
  static const String trainees = '/traineesScreen';
  static const String traineesGroupsByAge = '/traineesGroupsByAge';
  static const String trainee = '/trainee';
  static const String splash = '/splash';
  static const String enterInfo = '/enterInfo';
  static const String myPlans = '/myPlans';
  static const String plan = '/plan';
  static const String userStatistics = '/userStatistics';
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.home:
      return MaterialPageRoute(builder: (_) => CoachDashboard());
    case Routes.myGym:
      return MaterialPageRoute(builder: (_) => MyGymScreen());
    case Routes.singUp:
      return MaterialPageRoute(builder: (_) => const SignUpScreen());
    case Routes.singIn:
      return MaterialPageRoute(builder: (_) => const LoginScreen());
    case Routes.preLogin:
      return MaterialPageRoute(builder: (_) => const PreLoginScreen());
    case Routes.trainees:
      return MaterialPageRoute(builder: (_) => const TraineesScreen());
    case Routes.traineesGroupsByAge:
      return MaterialPageRoute(builder: (_) => const TraineesGroupsByAgeScreen());
    case Routes.trainee:
      return MaterialPageRoute(builder: (_) => const TraineesScreen());
    case Routes.splash:
      return MaterialPageRoute(builder: (_) => const SplashScreen());
    case Routes.enterInfo:
      return MaterialPageRoute(builder: (_) => EnteInfoScreen());
    case Routes.myPlans:
      return MaterialPageRoute(builder: (_) => const MyPlansScreen());
    case Routes.plan:
      return MaterialPageRoute(builder: (_) => const PlanScreen());
    case Routes.userStatistics:
      return MaterialPageRoute(builder: (_) => const UserStatisticsScreen());

    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(child: Text('No route defined for ${settings.name}')),
        ),
      );
  }
}
