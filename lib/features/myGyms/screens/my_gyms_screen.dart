import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/widgets/coach_nav_bar.dart';
import 'package:ironfit/features/myGyms/widgets/my_gyms_body.dart';

class MyGymsScreen extends StatelessWidget {
  const MyGymsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const MyGymsBody(),
      bottomNavigationBar: CoachNavBar(),
    );
  }
}
