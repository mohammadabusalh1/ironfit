import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/uploadImage.dart';
import 'package:ironfit/core/routes/routes.dart';

class UserEnterInfoBody extends StatefulWidget {
  UserEnterInfoBody({Key? key}) : super(key: key);

  @override
  _UserEnterInfoBodyState createState() => _UserEnterInfoBodyState();
}

class _UserEnterInfoBodyState extends State<UserEnterInfoBody> {
  final _formKey = GlobalKey<FormState>();
  String? _uploadedImageUrl;
  int stage = 1;
  String userId = FirebaseAuth.instance.currentUser!.uid;

  // Controllers for the form fields
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  String? _selectedGender; // To hold the selected gender
  final List<String> _genders = ['ذكر', 'انثى', 'أخر'];

  Future<void> updateCoachInfo(String userId, Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance
          .collection('trainees')
          .doc(userId)
          .update(data);
    } on FirebaseException catch (e) {
      throw e;
    } catch (e) {
      throw e;
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        if (stage == 1) {
          setState(() {
            stage = 2;
          });
        } else if (stage == 2) {
          setState(() {
            stage = 3;
          });
        } else {
          Get.dialog(const Center(child: CircularProgressIndicator()),
              barrierDismissible: false);

          if (_selectedGender == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('يرجى اختيار الجنس')),
            );
          }

          Map<String, dynamic> userData = {
            'username': _usernameController.text,
            'firstName': _firstNameController.text,
            'lastName': _lastNameController.text,
            'gender': _selectedGender,
            'age': int.parse(_ageController.text),
            'weight': double.parse(_weightController.text),
            'length': double.parse(_lengthController.text),
            'profileImageUrl': _uploadedImageUrl, // Add the image URL
          };
          await updateCoachInfo(userId, userData).then(
            (value) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم إنشاء الحساب بنجاح')),
              );

              Navigator.of(context).pop();
              Get.toNamed(Routes.trainerDashboard);
            },
          ).catchError((error) {
            print(error);
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('حدث خطأ: $error')),
            );
          });
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageStack(),
              const SizedBox(height: 24),
              stage == 3
                  ? ImagePickerComponent(
                      userId: userId,
                      onImageUploaded: (imageUrl) {
                        setState(() {
                          _uploadedImageUrl = imageUrl;
                        });
                      })
                  : Container(), // Add the image picker button here
              stage == 1 ? const SizedBox(height: 12) : Container(),
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
              stage == 1 ? const SizedBox(height: 12) : Container(),
              stage == 1
                  ? const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text('الحساب',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    )
                  : Container(),
              stage == 1 ? const SizedBox(height: 12) : Container(),
              stage == 1
                  ? _buildTextField('إسم الحساب', '', _usernameController,
                      TextInputType.text, Icons.person)
                  : Container(),
              stage == 1 ? const SizedBox(height: 12) : Container(),
              stage == 1
                  ? _buildTextField('الاسم الأول', '', _firstNameController,
                      TextInputType.text, Icons.face)
                  : Container(),
              stage == 1 ? const SizedBox(height: 12) : Container(),
              stage == 1
                  ? _buildTextField('إسم العائلة', '', _lastNameController,
                      TextInputType.text, Icons.face)
                  : Container(),
              stage == 2 ? const SizedBox(height: 12) : Container(),
              stage == 2
                  ? const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text('البيانات الشخصية',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    )
                  : Container(),
              stage == 2 ? const SizedBox(height: 12) : Container(),
              stage == 2
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: DropdownButton<String>(
                        dropdownColor:
                            Palette.secondaryColor, // Dropdown background color
                        style:
                            const TextStyle(color: Palette.gray, fontSize: 14),
                        value: _selectedGender,
                        isExpanded:
                            true, // Make the dropdown take the full width
                        hint: Text(
                          'إختر الجنس',
                          style: const TextStyle(
                              color: Palette.gray), // Hint style
                        ),
                        items: _genders.map((String gender) {
                          return DropdownMenuItem<String>(
                            alignment: Alignment.centerRight,
                            value: gender,
                            child: Text(
                              gender,
                              textAlign: TextAlign.right,
                            ), // Display gender
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedGender =
                                newValue; // Update selected gender
                          });
                        },
                      ),
                    )
                  : Container(),
              stage == 2 ? const SizedBox(height: 12) : Container(),
              stage == 2
                  ? _buildTextField('العمر', '', _ageController,
                      TextInputType.number, Icons.group)
                  : Container(),
              stage == 2 ? const SizedBox(height: 12) : Container(),
              stage == 2
                  ? _buildTextField('الوزن', '', _weightController,
                      TextInputType.number, Icons.scale)
                  : Container(),
              stage == 2 ? const SizedBox(height: 12) : Container(),
              stage == 2
                  ? _buildTextField('الطول', '', _lengthController,
                      TextInputType.number, Icons.accessibility)
                  : Container(),
              const SizedBox(height: 24),
              Padding(
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
              ), // Adds extra space to ensure scrolling
            ],
          ),
        ),
        // The fixed login button at the bottom
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

  Widget _buildTextField(
    String label,
    String hint,
    TextEditingController controller,
    TextInputType keyboardType,
    IconData? icon,
  ) {
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
          fillColor: Palette.secondaryColor,
          enabledBorder: _buildInputBorder(Palette.mainAppColor),
          focusedBorder: _buildInputBorder(Palette.white),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10.0), // Adjust padding if needed
            child: Icon(
              icon,
              color: Palette.gray,
              size: 20,
            ),
          ),
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
