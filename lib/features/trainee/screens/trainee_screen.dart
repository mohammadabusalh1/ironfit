import 'package:flutter/material.dart';
import 'package:ironfit/features/Trainee/widgets/trainee_body.dart';

class TraineeScreen extends StatelessWidget {
  const TraineeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: TraineeBody(),
    );
  }
}
