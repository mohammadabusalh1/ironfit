import 'package:flutter/material.dart';
import 'package:ironfit/features/traineesGroupsbyAge/widgets/trainees_groups_by_age_body.dart';

class TraineesGroupsByAgeScreen extends StatelessWidget {
  const TraineesGroupsByAgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: TraineesGroupsByAgeBody(),
    );
  }
}
