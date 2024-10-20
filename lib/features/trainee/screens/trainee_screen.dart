import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/widgets/coach_nav_bar.dart';
import 'package:ironfit/features/Trainee/widgets/trainee_body.dart';

class TraineeScreen extends StatelessWidget {
  final String username;
  final Function fetchTrainees;
  const TraineeScreen({super.key, required this.username, required this.fetchTrainees});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TraineeBody(
        username: username,
        fetchTrainees: fetchTrainees,
      ),
      bottomNavigationBar: CoachNavBar(),
    );
  }
}
