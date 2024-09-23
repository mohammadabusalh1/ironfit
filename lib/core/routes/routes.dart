import 'package:flutter/material.dart';
import 'package:ironfit/features/dashboard/screens/coach_dashboard.dart';
import 'package:ironfit/features/my_gym/screens/my_gym_screen.dart';
import 'package:ironfit/features/Trainees/screens/Trainees_screen.dart';
import 'package:ironfit/features/preLoginScreens/screens/pre_login_screen.dart';
import 'package:ironfit/features/regestraion/login/screens/login_screen.dart';
import 'package:ironfit/features/regestraion/register/screens/sing_up_screen.dart';
import 'package:ironfit/features/traineesGroupsbyAge/screens/trainees_groups_by_age_screen.dart';

class Routes {
  static const String home = '/';
  static const String coachDashboard = '/coachDashboard';
  static const String myGym = '/gymScreen';
  static const String singUp = '/singUpScreen';
  static const String singIn = '/singInScreen';
  static const String login = '/singInScreen';
  static const String preLogin = '/preLoginScreen';
  static const String trainees = '/traineesScreen';
  static const String traineesGroupsByAge = '/traineesGroupsByAge';
  static const String trainee = '/trainee';
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
      return MaterialPageRoute(builder: (_) => TraineesGroupsByAgeScreen());
    case Routes.trainee:
      return MaterialPageRoute(builder: (_) => const TraineesScreen());

    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(child: Text('No route defined for ${settings.name}')),
        ),
      );
  }
}
