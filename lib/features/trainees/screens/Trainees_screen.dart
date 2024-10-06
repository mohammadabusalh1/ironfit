import 'package:flutter/material.dart';
import 'package:ironfit/core/presention/widgets/coach_nav_bar.dart';
import 'package:ironfit/features/Trainees/widgets/Trainees_body.dart';

class TraineesScreen extends StatelessWidget {
  const TraineesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const TraineesBody(),
      bottomNavigationBar: CoachNavBar(),
    );
  }
}
