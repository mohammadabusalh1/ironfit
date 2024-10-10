import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/widgets/app_bar.dart';
import 'package:ironfit/core/presentation/widgets/coach_nav_bar.dart';
import 'package:ironfit/features/userStatistics/widgets/user_statistics_body.dart';
class UserStatisticsScreen extends StatelessWidget {
  const UserStatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UserStatisticsBody(),
    );
  }
}
