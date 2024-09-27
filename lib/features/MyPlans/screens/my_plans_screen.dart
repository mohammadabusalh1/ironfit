import 'package:flutter/material.dart';
import 'package:ironfit/features/MyPlans/widgets/my_plans_body.dart';
import 'package:ironfit/core/presention/widgets/nav_bar.dart';

class MyPlansScreen extends StatelessWidget {
  const MyPlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyPlansBody(),
      bottomNavigationBar: NavBar(),
    );
  }
}
