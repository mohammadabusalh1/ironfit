import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart' as img;
import 'package:ironfit/core/routes/routes.dart';
import 'package:ironfit/core/presentation/widgets/customSnackbar.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';

class CoachEnterInfoController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final ageController = TextEditingController();
  final experienceController = TextEditingController();
  final usernameController = TextEditingController();
  
  final RxInt stage = 1.obs;
  final Rx<File?> selectedImage = Rx<File?>(null);
  final CustomSnackbar customSnackbar = CustomSnackbar();

  final Function registerCoach;

  CoachEnterInfoController({required this.registerCoach});

  Future<void> updateCoachInfo(String coachId, Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance
          .collection('coaches')
          .doc(coachId)
          .update(data);
    } catch (e) {
      print('Error updating coach info: $e');
    }
  }

  Future<String> uploadImage(String userId) async {
    if (selectedImage.value == null) return '';
    
    try {
      final bytes = await selectedImage.value!.readAsBytes();
      final image = img.decodeImage(bytes);
      if (image == null) return '';

      final resizedImage = img.copyResize(
        image,
        width: 800,
        maintainAspect: true,
        interpolation: img.Interpolation.linear,
      );

      final compressedBytes = img.encodeJpg(resizedImage, quality: 70);
      final tempDir = await Directory.systemTemp.createTemp();
      final tempFile = File('${tempDir.path}/compressed_$userId.jpg');
      await tempFile.writeAsBytes(compressedBytes);

      final storageRef = FirebaseStorage.instance.ref().child('profile_images/$userId.jpg');
      await storageRef.putFile(tempFile, SettableMetadata(contentType: 'image/jpeg'));

      await tempFile.delete();
      await tempDir.delete();

      return await storageRef.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }

  Future<bool> checkIfUsernameExists(String username) async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('coaches')
          .where('username', isEqualTo: username)
          .get();
      return snapshot.docs.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  void setImage(File image) {
    selectedImage.value = image;
  }

  void goBack() {
    stage.value = 1;
  }

  String? validator(String? value) {
    if (value?.isEmpty ?? true) {
      return LocalizationService.translateFromGeneral('thisFieldRequired');
    }
    return null;
  }

  Future<void> submitForm(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      customSnackbar.showInvalidFormatMessage(context);
      return;
    }

    try {
      if (stage.value == 1) {
        bool usernameExists = await checkIfUsernameExists(usernameController.text);
        if (usernameExists) {
          customSnackbar.showMessage(
              context, LocalizationService.translateFromGeneral('usernameExistsError'));
          return;
        }
        stage.value = 2;
        return;
      }

      Get.dialog(const Center(child: CircularProgressIndicator()),
          barrierDismissible: false);

      String coachId = await registerCoach();
      String uploadedImageUrl = await uploadImage(coachId);

      Map<String, dynamic> coachData = {
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'age': int.tryParse(ageController.text) ?? 0,
        'experience': int.tryParse(experienceController.text) ?? 0,
        'profileImageUrl': uploadedImageUrl,
        'username': usernameController.text,
      };

      await updateCoachInfo(coachId, coachData);
      customSnackbar.showSuccessMessage(context);

      Get.toNamed(Routes.coachDashboard)?.then((value) => Get.back());
    } catch (e) {
      Get.back();
      customSnackbar.showFailureMessage(context);
    }
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    ageController.dispose();
    experienceController.dispose();
    usernameController.dispose();
    super.onClose();
  }
} 