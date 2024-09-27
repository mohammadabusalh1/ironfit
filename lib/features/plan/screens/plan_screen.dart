import 'package:flutter/material.dart';
import 'package:ironfit/core/presention/widgets/nav_bar.dart';
import 'package:ironfit/features/plan/widgets/plan_body.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PlanBody(),
      bottomNavigationBar: NavBar(),
    );
  }
}
