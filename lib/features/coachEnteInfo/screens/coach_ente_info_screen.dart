import 'package:flutter/material.dart';
import 'package:ironfit/features/coachEnteInfo/widgets/coach_ente_info_body.dart';

class CoachEnterInfoScreen extends StatelessWidget {
  Function registerCoach;
// Accept coach ID here
  CoachEnterInfoScreen({super.key, required this.registerCoach});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CoachEnterInfoBody(
        registerCoach: registerCoach,
      ),
    );
  }
}
