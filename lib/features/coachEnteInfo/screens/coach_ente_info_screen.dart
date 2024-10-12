import 'package:flutter/material.dart';
import 'package:ironfit/features/coachEnteInfo/widgets/coach_ente_info_body.dart';

class CoachEnterInfoScreen extends StatelessWidget {
  final String coachId; // Accept coach ID here

  CoachEnterInfoScreen({Key? key, required this.coachId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CoachEnterInfoBody(
        coachId: this.coachId,
      ),
    );
  }
}
