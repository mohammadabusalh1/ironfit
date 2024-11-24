import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/widgets/Button.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';
import 'package:ironfit/core/presentation/widgets/uploadImage.dart';
import 'package:ironfit/features/coachEnteInfo/controllers/coach_enter_info_controller.dart';
import 'package:ironfit/features/editPlan/widgets/BuildTextField.dart';

class CoachEnterInfoBody extends StatelessWidget {
  final Function registerCoach;

  CoachEnterInfoBody({super.key, required this.registerCoach});

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put(CoachEnterInfoController(registerCoach: registerCoach));
    final dir = LocalizationService.getDir();

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                // Center(child: _buildImageStack()),
                Obx(() => _buildFormFields(context, controller, dir)),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomButtons(context, controller),
    );
  }

  Widget _buildImageStack() {
    return Stack(
      children: [
        // _buildImage('assets/images/signOne.jpeg'),
        _buildImage('assets/images/IronFit.png'),
      ],
    );
  }

  Widget _buildImage(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        imagePath,
        width: 250,
        height: 60,
        fit: BoxFit.fitWidth,
      ),
    );
  }

  Widget _buildFormFields(
      BuildContext context, CoachEnterInfoController controller, String dir) {
    return Column(
      children: [
        const SizedBox(height: 24),
        ImagePickerComponent(
          onImageUploaded: controller.setImage,
        ),
        const SizedBox(height: 24),
        BuildTextField(
          dir: dir,
          controller: controller.firstNameController,
          label: LocalizationService.translateFromGeneral('firstNameLabel'),
          validator: controller.validator,
        ),
        const SizedBox(height: 16),
        BuildTextField(
          dir: dir,
          controller: controller.lastNameController,
          label: LocalizationService.translateFromGeneral('lastNameLabel'),
          validator: controller.validator,
        ),
        const SizedBox(height: 16),
        BuildTextField(
          dir: dir,
          controller: controller.ageController,
          label: LocalizationService.translateFromGeneral('age'),
          validator: controller.validator,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        BuildTextField(
          dir: dir,
          controller: controller.experienceController,
          label: LocalizationService.translateFromGeneral('experience'),
          validator: controller.validator,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        BuildTextField(
          dir: dir,
          controller: controller.usernameController,
          label: LocalizationService.translateFromGeneral('usernameLabel'),
          validator: controller.validator,
        ),
      ],
    );
  }

  Widget _buildBottomButtons(
      BuildContext context, CoachEnterInfoController controller) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          BuildIconButton(
            onPressed: () => controller.submitForm(context),
            text: LocalizationService.translateFromGeneral('next'),
            width: 150,
            fontSize: 14,
          ),
          const SizedBox(width: 12),
          BuildIconButton(
            onPressed: controller.goBack,
            text: LocalizationService.translateFromGeneral('goBack'),
            width: 150,
            fontSize: 14,
          ),
        ],
      ),
    );
  }
}
