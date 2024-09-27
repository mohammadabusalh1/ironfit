import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presention/widgets/nav_bar.dart';
import 'package:ironfit/features/enteInfo/widgets/ente_info_body.dart';
import 'package:ironfit/features/my_gym/controllers/my_gym_controller.dart';

class EnteInfoScreen extends StatelessWidget {
  // final MyGymController controller = Get.put(MyGymController());

  EnteInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EnteInfoBody(),
      bottomNavigationBar: Directionality(
        textDirection: TextDirection.ltr,
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 24),
          child: ElevatedButton.icon(
            onPressed: () {
              print('Button pressed ...');
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
              backgroundColor: const Color(0xFFFFBB02), // Background color
              minimumSize: Size(
                  MediaQuery.of(context).size.width, 55), // Width and height
              padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
              shadowColor: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
