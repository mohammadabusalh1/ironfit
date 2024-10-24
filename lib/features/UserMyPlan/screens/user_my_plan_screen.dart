import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/widgets/user_nav_bar.dart';
import 'package:ironfit/features/UserMyPlan/widgets/user_my_plan_body.dart';

class UserMyPlanScreen extends StatelessWidget {
  const UserMyPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const UserMyPlanBody(),
      bottomNavigationBar: UserNavBar(),
    );
  }
}
