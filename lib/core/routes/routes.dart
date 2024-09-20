import 'package:flutter/material.dart';
import 'package:ironfit/features/dashboard/screens/coach_dashboard.dart';
import 'package:ironfit/features/my_gym/screens/my_gym_screen.dart';
import 'package:ironfit/features/regestraion/register/screens/sing_up_screen.dart';


class Routes {
  static const String home = '/';
  static const String coachDashboard = '/coachDashboard';
  static const String myGym = '/gymScreen';
  static const String singUp = '/singUpScreen';
  static const String singIn = '/singInScreen';
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
      return MaterialPageRoute(builder: (_) => const SignUpScreen());

    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(child: Text('No route defined for ${settings.name}')),
        ),
      );
  }
}
