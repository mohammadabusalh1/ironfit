import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/widgets/coach_nav_bar.dart';
import 'package:ironfit/features/Trainee/widgets/trainee_body.dart';

class TraineeScreen extends StatelessWidget {
  final String email;
  const TraineeScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TraineeBody(
        email: email,
      ),
      bottomNavigationBar: CoachNavBar(),
    );
  }
}
