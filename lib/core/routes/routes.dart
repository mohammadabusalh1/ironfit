import 'package:flutter/material.dart';
import 'package:ironfit/features/dashboard/screens/coach_dashboard.dart';


class Routes {
  static const String home = '/';
  static const String coachDashboard = '/coachDashboard';
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.home:
      return MaterialPageRoute(builder: (_) =>  CoachDashboard());

    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(child: Text('No route defined for ${settings.name}')),
        ),
      );
  }
}
