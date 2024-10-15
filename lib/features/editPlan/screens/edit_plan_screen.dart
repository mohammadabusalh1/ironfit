import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/widgets/coach_nav_bar.dart';
import 'package:ironfit/features/editPlan/widgets/edit_plan_body.dart';

class EditPlanScreen extends StatelessWidget {
  const EditPlanScreen({super.key, required this.planId});

  final String planId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EditPlanBody(planId: planId),
      bottomNavigationBar: CoachNavBar(),
    );
  }
}
