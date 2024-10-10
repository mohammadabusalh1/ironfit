import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/widgets/coach_nav_bar.dart';
import 'package:ironfit/features/Trainee/widgets/trainee_body.dart';

class TraineeScreen extends StatelessWidget {
  const TraineeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const TraineeBody(),
      bottomNavigationBar: CoachNavBar(),
    );
  }
}
