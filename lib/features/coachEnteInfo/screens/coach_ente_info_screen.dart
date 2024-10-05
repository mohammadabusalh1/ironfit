import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:ironfit/features/coachEnteInfo/widgets/coach_ente_info_body.dart';

class CoachEnterInfoScreen extends StatelessWidget {
  // final MyGymController controller = Get.put(MyGymController());

  CoachEnterInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CoachEnterInfoBody(),
        bottomNavigationBar: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 24),
          child: ElevatedButton.icon(
            onPressed: () {
              Get.toNamed(Routes.coachDashboard);
            },
            icon: const Icon(
              Icons.west,
              size: 24,
              color: Color(0xFF1C1503), // Icon color
            ),
            label: const Text(
              'التالي',
              style: TextStyle(
                fontFamily: 'Inter',
                color: Color(0xFF1C1503), // Text color
                fontSize: 18,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color(0xFF1C1503),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              backgroundColor: const Color(0xFFFFBB02),
              textStyle: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                letterSpacing: 0,
                fontWeight: FontWeight.bold,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ));
  }
}
