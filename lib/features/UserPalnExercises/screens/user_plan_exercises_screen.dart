import 'package:flutter/material.dart';
import 'package:ironfit/core/presention/widgets/nav_bar.dart';
import 'package:ironfit/features/UserPalnExercises/widgets/user_plan_exercises_body.dart';
class UserPalnExercisesScreen extends StatelessWidget {
  const UserPalnExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UserPalnExercisesBody(),
      bottomNavigationBar: NavBar(),
    );
  }
}