import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/uploadImage.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserEnterInfoBody extends StatefulWidget {
  final String userId; // Accept coach ID here

  UserEnterInfoBody({Key? key, required this.userId}) : super(key: key);

  @override
  _UserEnterInfoBodyState createState() => _UserEnterInfoBodyState();
}

class _UserEnterInfoBodyState extends State<UserEnterInfoBody> {
  final _formKey = GlobalKey<FormState>();
  String? _uploadedImageUrl;
  int stage = 1;

  // Controllers for the form fields
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();

  Future<void> updateCoachInfo(String userId, Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance
          .collection('trainees')
          .doc(userId)
          .update(data);
      // Show success message
      Get.snackbar('Success', 'Coach information updated successfully.',
          backgroundColor: Colors.green, colorText: Colors.white);
    } on FirebaseException catch (e) {
      // Handle Firebase specific errors
      Get.snackbar('Error', 'Firebase error: ${e.message}',
          backgroundColor: Colors.red, colorText: Colors.white);
    } catch (e) {
      // Handle any other errors
      Get.snackbar(
          'Error', 'An unexpected error occurred. Please try again later.',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        if (stage == 1) {
          setState(() {
            stage = 2;
          });
        } else {
          Get.dialog(Center(child: CircularProgressIndicator()),
              barrierDismissible: false);
          Map<String, dynamic> userData = {
            'username': _usernameController.text,
            'firstName': _firstNameController.text,
            'lastName': _lastNameController.text,
            'age': int.parse(_ageController.text),
            'weight': double.parse(_weightController.text),
            'length': double.parse(_lengthController.text),
            'profileImageUrl': _uploadedImageUrl, // Add the image URL
          };
          await updateCoachInfo(widget.userId, userData);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم إنشاء الحساب بنجاح')),
          );

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('userId', widget.userId);

          Navigator.of(context).pop();
          Get.toNamed(Routes.trainerDashboard);
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('المعلومات غير صالحة')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  _buildImageStack(),
                  const SizedBox(height: 24),
                  stage == 2
                      ? ImagePickerComponent(
                          userId: widget.userId,
                          onImageUploaded: (imageUrl) {
                            setState(() {
                              _uploadedImageUrl = imageUrl;
                            });
                          })
                      : Container(), // Add the image picker button here
                  const SizedBox(height: 12),
                  stage == 1
                      ? const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: Align(
                            alignment: AlignmentDirectional.center,
                            child: Text(
                              'أكمل معلوماتك من فضلك',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  const SizedBox(height: 12),
                  stage == 1
                      ? _buildLabelWithTextField(
                          'إسم الحساب', _usernameController)
                      : Container(),
                  stage == 1
                      ? _buildLabelWithTextField(
                          'الاسم الأول', _firstNameController)
                      : Container(),
                  stage == 1
                      ? _buildLabelWithTextField(
                          'إسم العائلة', _lastNameController)
                      : Container(),
                  stage == 1
                      ? _buildLabelWithTextField('العمر', _ageController,
                          keyboardType: TextInputType.number)
                      : Container(),
                  stage == 1
                      ? _buildLabelWithTextField('الوزن', _weightController,
                          keyboardType: TextInputType.number)
                      : Container(),
                  stage == 1
                      ? _buildLabelWithTextField('الطول', _lengthController,
                          keyboardType: TextInputType.number)
                      : Container(),
                  const SizedBox(
                      height: 100), // Adds extra space to ensure scrolling
                ],
              ),
            ),
            // The fixed login button at the bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 24),
                child: ElevatedButton.icon(
                  onPressed: _submitForm,
                  label: const Text(
                    'التالي',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color: Palette.white, // Text color
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  icon: const Icon(
                    Icons.west,
                    size: 20,
                    color: Palette.white, // Icon color
                  ),
                  iconAlignment: IconAlignment.end,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color(0xFF1C1503),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    backgroundColor: const Color(0xFFFFBB02),
                    textStyle: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageStack() {
    return Stack(
      children: [
        _buildImage(Assets.signOne),
        _buildImage(Assets.ironFitLogo),
      ],
    );
  }

  Widget _buildImage(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        imagePath,
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildLabelWithTextField(
      String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      children: [
        _buildTextField(
            label: label,
            hint: label,
            controller: controller,
            keyboardType: keyboardType),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          hintStyle: const TextStyle(color: Palette.gray, fontSize: 14),
          labelStyle: const TextStyle(color: Palette.gray, fontSize: 14),
          filled: true,
          fillColor: const Color(0xFF454038),
          enabledBorder: _buildInputBorder(Palette.mainAppColor),
          focusedBorder: _buildInputBorder(Palette.white),
        ),
        style: const TextStyle(color: Palette.white, fontSize: 14),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'من فضلك أدخل $label';
          }
          return null;
        },
      ),
    );
  }

  OutlineInputBorder _buildInputBorder(Color borderColor) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: borderColor, width: 1),
      borderRadius: BorderRadius.circular(10),
    );
  }
}
