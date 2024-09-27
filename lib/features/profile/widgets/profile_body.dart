import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presention/style/palette.dart';
import 'package:ironfit/core/presention/widgets/custom_text_widget.dart';
import 'package:ironfit/features/profile/controllers/profile_controller.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find();

    return Scaffold(
      backgroundColor: Palette.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              backgroundColor: Palette.subTitleGrey,
              radius: 60,
              backgroundImage: (controller.userProfile.value.profileImage.isNotEmpty)
                  ? AssetImage(controller.userProfile.value.profileImage)  // Show the image if available
                  : null,
              child: (controller.userProfile.value.profileImage.isEmpty)
                  ? const Icon(
                Icons.person,
                color: Palette.mainAppColor,
                size: 50,
              )
                  : null,
            ),

            const SizedBox(height: 10),
            Obx(() => CustomTextWidget(
                  text: controller.userProfile.value.userName,
                  fontSize: 24,
                  color: Colors.white,
                )),
            Obx(() => CustomTextWidget(
                  text: controller.userProfile.value.email,
                  fontSize: 16,
                  color: Colors.white,
                )),
            const SizedBox(height: 20),

            // Gym Info Fields (Height, Weight, Age)
            Card(
              color: Palette.subTitleBlack,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Height
                    _buildField('Height', controller.displayHeight),
                    // Weight
                    _buildField('Weight', controller.displayWeight),
                    // Age
                    _buildField(
                        'Age', controller.userProfile.value.age.toString()),

                    const SizedBox(height: 20),

                    // Unit Switch
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomTextWidget(
                          text: 'Units',
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        Obx(() => Switch(
                              value: controller.isMetric.value,
                              onChanged: (value) =>
                                  controller.toggleUnits(value),
                              activeColor: Palette.mainAppColor,
                            )),
                        Obx(() => Text(
                              controller.isMetric.value ? 'Metric' : 'Imperial',
                              style: const TextStyle(fontSize: 16),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Calculate Button
            ElevatedButton(
              onPressed: () {
                final bmi = controller.calculateBMI();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Your BMI is ${bmi.toStringAsFixed(1)}",
                      style: const TextStyle(color: Palette.mainAppColor),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Palette.mainAppColor,
                  shadowColor: Palette.subTitleGrey),
              child: const CustomTextWidget(
                text: 'Calculate BMI',
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper to build fields
  Widget _buildField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomTextWidget(
            text: label,
            fontSize: 16,
            color: Colors.white,
          ),
          CustomTextWidget(
            text: value,
            fontSize: 16,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
