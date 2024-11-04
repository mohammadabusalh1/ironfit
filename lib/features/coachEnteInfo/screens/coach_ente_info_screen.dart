import 'package:flutter/material.dart';
import 'package:ironfit/features/coachEnteInfo/widgets/coach_ente_info_body.dart';

class CoachEnterInfoScreen extends StatelessWidget {
  Function registerCoach;
// Accept coach ID here
  CoachEnterInfoScreen({Key? key, required this.registerCoach})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CoachEnterInfoBody(
        registerCoach: registerCoach,
      ),
    );
  }
}
