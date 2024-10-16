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
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();

  Future<void> updateCoachInfo(String userId, Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection('trainees')
        .doc(userId)
        .update(data);
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        if (stage == 1) {
          setState(() {
            stage = 2;
          });
        } else {
          Map<String, dynamic> userData = {
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
    return Form(
      key: _formKey,
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
          const SizedBox(height: 24),
          stage == 1
              ? _buildLabelWithTextField('الاسم الأول', _firstNameController)
              : Container(),
          stage == 1
              ? _buildLabelWithTextField('إسم العائلة', _lastNameController)
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
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 24),
              child: ElevatedButton.icon(
                onPressed: _submitForm,
                label: const Text(
                  'التالي',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: Palette.black, // Text color
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                icon: const Icon(
                  Icons.west,
                  size: 22,
                  color: Palette.black, // Icon color
                ),
                iconAlignment: IconAlignment.end,
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xFF1C1503),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                  backgroundColor: const Color(0xFFFFBB02),
                  textStyle: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        ],
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
        const SizedBox(height: 24),
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
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          labelStyle: const TextStyle(color: Colors.white, fontSize: 14),
          filled: true,
          fillColor: const Color(0xFF454038),
          enabledBorder: _buildInputBorder(const Color(0xFFFFBB02)),
          focusedBorder: _buildInputBorder(Colors.white),
        ),
        style: const TextStyle(color: Colors.white, fontSize: 14),
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
