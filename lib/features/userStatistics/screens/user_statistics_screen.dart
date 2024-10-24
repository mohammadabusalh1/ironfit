import 'package:flutter/material.dart';
import 'package:ironfit/features/userStatistics/widgets/user_statistics_body.dart';
class UserStatisticsScreen extends StatelessWidget {
  const UserStatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: UserStatisticsBody(),
    );
  }
}
