import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/CheckTockens.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';
import 'package:ironfit/core/presentation/widgets/uploadImage.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:ironfit/features/editPlan/widgets/BuildTextField.dart';

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
  final List<String> _genders = [
    LocalizationService.translateFromGeneral('male'),
    LocalizationService.translateFromGeneral('female'),
    LocalizationService.translateFromGeneral('other')
  ];

  TokenService tokenService = TokenService();

  @override
  void initState() {
    super.initState();
    tokenService.checkTokenAndNavigateDashboard();
  }

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
          if (_selectedGender == null || _selectedGender!.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(LocalizationService.translateFromGeneral(
                      'SelectGender'))),
            );
            return;
          }
          setState(() {
            stage = 3;
          });
        } else {
          Get.dialog(const Center(child: CircularProgressIndicator()),
              barrierDismissible: false);

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
                SnackBar(
                    content: Text(LocalizationService.translateFromGeneral(
                        'accountCreationSuccess'))),
              );

              Navigator.of(context).pop();
              Get.toNamed(Routes.trainerDashboard);
            },
          ).catchError((error) {
            print(error);
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(
                      '${LocalizationService.translateFromGeneral('unexpectedError')} $error')),
            );
          });
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  '${LocalizationService.translateFromGeneral('unexpectedError')} $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(LocalizationService.translateFromGeneral(
                'invalidInformationMessage'))),
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
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Align(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          LocalizationService.translateFromGeneral(
                              'completeInfoPrompt'),
                          style: AppStyles.textCairo(
                            16,
                            Palette.mainAppColorWhite,
                            FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  : Container(),
              stage == 1 ? const SizedBox(height: 12) : Container(),
              stage == 1
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                          LocalizationService.translateFromGeneral('account'),
                          style: AppStyles.textCairo(
                            16,
                            Palette.mainAppColorWhite,
                            FontWeight.bold,
                          )),
                    )
                  : Container(),
              stage == 1 ? const SizedBox(height: 12) : Container(),
              stage == 1
                  ? BuildTextField(
                      label: LocalizationService.translateFromGeneral(
                          'usernameLabel'),
                      controller: _usernameController,
                      keyboardType: TextInputType.text,
                      icon: Icons.person)
                  : Container(),
              stage == 1 ? const SizedBox(height: 12) : Container(),
              stage == 1
                  ? BuildTextField(
                      label: LocalizationService.translateFromGeneral(
                          'firstNameLabel'),
                      controller: _firstNameController,
                      keyboardType: TextInputType.text,
                      icon: Icons.face)
                  : Container(),
              stage == 1 ? const SizedBox(height: 12) : Container(),
              stage == 1
                  ? BuildTextField(
                      label: LocalizationService.translateFromGeneral(
                          'lastNameLabel'),
                      controller: _lastNameController,
                      keyboardType: TextInputType.text,
                      icon: Icons.face)
                  : Container(),
              stage == 2 ? const SizedBox(height: 12) : Container(),
              stage == 2
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                          LocalizationService.translateFromGeneral(
                              'personalInfoSection'),
                          style: AppStyles.textCairo(
                            16,
                            Palette.mainAppColorWhite,
                            FontWeight.bold,
                          )),
                    )
                  : Container(),
              stage == 2 ? const SizedBox(height: 12) : Container(),
              stage == 2
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: DropdownButton<String>(
                        dropdownColor:
                            Palette.secondaryColor, // Dropdown background color
                        style: AppStyles.textCairo(
                          14,
                          Palette.gray,
                          FontWeight.w500,
                        ),
                        value: _selectedGender,
                        isExpanded:
                            true, // Make the dropdown take the full width
                        hint: Text(
                          LocalizationService.translateFromGeneral(
                              'SelectGender'),

                          style: AppStyles.textCairo(
                            14,
                            Palette.gray,
                            FontWeight.w500,
                          ), // Hint style
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
                  ? BuildTextField(
                      label: LocalizationService.translateFromGeneral('age'),
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      icon: Icons.group)
                  : Container(),
              stage == 2 ? const SizedBox(height: 12) : Container(),
              stage == 2
                  ? BuildTextField(
                      label: LocalizationService.translateFromGeneral('weight'),
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      icon: Icons.scale)
                  : Container(),
              stage == 2 ? const SizedBox(height: 12) : Container(),
              stage == 2
                  ? BuildTextField(
                      label: LocalizationService.translateFromGeneral('height'),
                      controller: _lengthController,
                      keyboardType: TextInputType.number,
                      icon: Icons.accessibility)
                  : Container(),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 24),
                child: ElevatedButton.icon(
                  onPressed: _submitForm,
                  label: Text(
                    LocalizationService.translateFromGeneral('next'),
                    style: AppStyles.textCairo(
                      16,
                      Palette.mainAppColorWhite,
                      FontWeight.w500,
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
                    textStyle: AppStyles.textCairo(
                      14,
                      Palette.mainAppColorWhite,
                      FontWeight.bold,
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
}
