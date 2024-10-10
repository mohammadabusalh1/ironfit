import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/widgets/coach_nav_bar.dart';
import 'package:ironfit/features/createPlan/widgets/create_plan_body.dart';

class CreatePlanScreen extends StatelessWidget {
  const CreatePlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const CreatePlanBody(),
      bottomNavigationBar: CoachNavBar(),
    );
  }
}
