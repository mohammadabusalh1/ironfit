import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/Button.dart';
import 'package:ironfit/core/presentation/widgets/CheckTockens.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';
import 'package:ironfit/core/presentation/widgets/customSnackbar.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';
import 'package:ironfit/core/presentation/widgets/theme.dart';
import 'package:ironfit/core/presentation/widgets/uploadImage.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:ironfit/features/editPlan/widgets/BuildTextField.dart';
import 'package:image/image.dart' as img;

class UserEnterInfoBody extends StatefulWidget {
  Function registerUser;
  UserEnterInfoBody({super.key, required this.registerUser});

  @override
  _UserEnterInfoBodyState createState() => _UserEnterInfoBodyState();
}

class _UserEnterInfoBodyState extends State<UserEnterInfoBody> {
  final _formKey = GlobalKey<FormState>();
  int stage = 1;
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
  CustomSnackbar customSnackbar = CustomSnackbar();
  late File _selectedImage;
  late String dir;

  @override
  void initState() {
    super.initState();
    tokenService.checkTokenAndNavigateDashboard();
    dir = LocalizationService.getDir();
  }

  Future<void> updateUserInfo(String userId, Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance
          .collection('trainees')
          .doc(userId)
          .update(data);
    } on FirebaseException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> _checkIfUsernameExists(String username) async {
    try {
      // Example query to check if the username exists in Firestore
      var snapshot = await FirebaseFirestore.instance
          .collection('trainees')
          .where('username', isEqualTo: username)
          .get();

      // If snapshot contains documents, username exists
      return snapshot.docs.isNotEmpty;
    } catch (e) {
      customSnackbar.showFailureMessage(context);
      return false;
    }
  }

  Future<String> _uploadImage(String userId) async {
    try {
      // Read image file
      final bytes = await _selectedImage.readAsBytes();
      final image = img.decodeImage(bytes);
      
      if (image == null) return '';
      
      // Resize the image to a maximum width of 800 pixels while maintaining aspect ratio
      final resizedImage = img.copyResize(
        image,
        width: 800,
        maintainAspect: true,
        interpolation: img.Interpolation.linear,
      );
      
      // Encode the image to jpg with reduced quality (0-100)
      final compressedBytes = img.encodeJpg(resizedImage, quality: 70);
      
      // Create a new temporary file with compressed image
      final tempDir = await Directory.systemTemp.createTemp();
      final tempFile = File('${tempDir.path}/compressed_$userId.jpg');
      await tempFile.writeAsBytes(compressedBytes);

      // Upload the compressed image
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images/$userId.jpg');

      await storageRef.putFile(
        tempFile,
        SettableMetadata(contentType: 'image/jpeg'),
      );

      // Clean up temporary file
      await tempFile.delete();
      await tempDir.delete();

      // Get the download URL
      final imageUrl = await storageRef.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        if (stage == 1) {
          bool usernameExists =
              await _checkIfUsernameExists(_usernameController.text);
          if (usernameExists) {
            setState(() {
              stage = 1;
            });
            customSnackbar.showMessage(
                context,
                LocalizationService.translateFromGeneral(
                    'usernameExistsError'));
            return;
          } else {
            setState(() {
              stage = 2;
            });
          }
        } else if (stage == 2) {
          if (_selectedGender == null || _selectedGender!.isEmpty) {
            customSnackbar.showMessage(context,
                LocalizationService.translateFromGeneral('selectGender'));
            return;
          }
          setState(() {
            stage = 3;
          });
        } else {
          Get.dialog(const Center(child: CircularProgressIndicator()),
              barrierDismissible: false);

          final userId = await widget.registerUser();
          String uploadedImageUrl = await _uploadImage(userId);

          var snapshot = await FirebaseFirestore.instance
              .collection('subscriptions')
              .where('username', isEqualTo: _usernameController.text)
              .get();

          if (snapshot.docs.isNotEmpty) {
            await snapshot.docs.first.reference.update({'userId': userId});
          }

          Map<String, dynamic> userData = {
            'username': _usernameController.text,
            'firstName': _firstNameController.text,
            'lastName': _lastNameController.text,
            'gender': _selectedGender,
            'age': int.parse(_ageController.text),
            'weight': double.parse(_weightController.text),
            'length': double.parse(_lengthController.text),
            'profileImageUrl': uploadedImageUrl,
            'subscriptionId':
                snapshot.docs.isNotEmpty ? snapshot.docs.first.id : '',
          };

          await updateUserInfo(userId, userData).then(
            (value) {
              customSnackbar.showMessage(
                  context,
                  LocalizationService.translateFromGeneral(
                      'accountCreationSuccess'));

              Navigator.of(context).pop();
              Get.toNamed(Routes.trainerDashboard);
            },
          ).catchError((error) async {
            print(error);
            customSnackbar.showMessage(context,
                LocalizationService.translateFromGeneral('unexpectedError'));
          });
        }
      } catch (e) {
        print(e);
        Navigator.of(context).pop();
        customSnackbar.showMessage(context,
            LocalizationService.translateFromGeneral('unexpectedError'));
      }
    } else {
      customSnackbar.showMessage(
          context,
          LocalizationService.translateFromGeneral(
              'invalidInformationMessage'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              Center(
                child: _buildImageStack(),
              ),
              const SizedBox(height: 24),
              stage == 3
                  ? ImagePickerComponent(onImageUploaded: (selectedImage) {
                      setState(() {
                        _selectedImage = selectedImage;
                      });
                    })
                  : Container(), // Add the image picker button here
              stage == 1 ? const SizedBox(height: 12) : Container(),
              stage == 1
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
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
              stage == 1 ? const SizedBox(height: 24) : Container(),
              stage == 1
                  ? Text(LocalizationService.translateFromGeneral('account'),
                      style: AppStyles.textCairo(
                        14,
                        Palette.mainAppColorWhite,
                        FontWeight.bold,
                      ))
                  : Container(),
              stage == 1 ? const SizedBox(height: 12) : Container(),
              stage == 1
                  ? BuildTextField(
                      dir: dir,
                      label: LocalizationService.translateFromGeneral(
                          'usernameLabel'),
                      controller: _usernameController,
                      keyboardType: TextInputType.text,
                      icon: Icons.account_circle,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocalizationService.translateFromGeneral(
                              'thisFieldRequired');
                        }
                        return null;
                      })
                  : Container(),
              stage == 1 ? const SizedBox(height: 12) : Container(),
              stage == 1
                  ? BuildTextField(
                      dir: dir,
                      label: LocalizationService.translateFromGeneral(
                          'firstNameLabel'),
                      controller: _firstNameController,
                      keyboardType: TextInputType.text,
                      icon: Icons.person,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocalizationService.translateFromGeneral(
                              'thisFieldRequired');
                        }
                        return null;
                      })
                  : Container(),
              stage == 1 ? const SizedBox(height: 12) : Container(),
              stage == 1
                  ? BuildTextField(
                      dir: dir,
                      label: LocalizationService.translateFromGeneral(
                          'lastNameLabel'),
                      controller: _lastNameController,
                      keyboardType: TextInputType.text,
                      icon: Icons.person,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocalizationService.translateFromGeneral(
                              'thisFieldRequired');
                        }
                        return null;
                      })
                  : Container(),
              stage == 2
                  ? Text(
                      LocalizationService.translateFromGeneral(
                          'personalInfoSection'),
                      style: AppStyles.textCairo(
                        14,
                        Palette.mainAppColorWhite,
                        FontWeight.bold,
                      ),
                    )
                  : Container(),
              stage == 2 ? const SizedBox(height: 12) : Container(),
              stage == 2
                  ? Theme(
                      data: customThemeData,
                      child: DropdownButtonFormField<String>(
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
                              'selectGender'),

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
                      dir: dir,
                      label: LocalizationService.translateFromGeneral('age'),
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      icon: Icons.group,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocalizationService.translateFromGeneral(
                              'thisFieldRequired');
                        }
                        return null;
                      })
                  : Container(),
              stage == 2 ? const SizedBox(height: 12) : Container(),
              stage == 2
                  ? BuildTextField(
                      dir: dir,
                      label: LocalizationService.translateFromGeneral('weight'),
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      icon: Icons.scale,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocalizationService.translateFromGeneral(
                              'thisFieldRequired');
                        }
                        return null;
                      })
                  : Container(),
              stage == 2 ? const SizedBox(height: 12) : Container(),
              stage == 2
                  ? BuildTextField(
                      dir: dir,
                      label: LocalizationService.translateFromGeneral('height'),
                      controller: _lengthController,
                      keyboardType: TextInputType.number,
                      icon: Icons.accessibility,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocalizationService.translateFromGeneral(
                              'thisFieldRequired');
                        }
                        return null;
                      })
                  : Container(),
              // Adds extra space to ensure scrolling
            ],
          ),
        )),
        // The fixed login button at the bottom
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            BuildIconButton(
              onPressed: _submitForm,
              text: LocalizationService.translateFromGeneral('next'),
              icon: Icons.east,
              iconAlignment: IconAlignment.start,
              width: Get.width * 0.42,
              fontSize: 14,
              textColor: Palette.mainAppColorWhite,
              iconColor: Palette.mainAppColorWhite,
              backgroundColor: Palette.greenActive,
            ),
            const SizedBox(width: 12),
            BuildIconButton(
              onPressed: () {
                if (stage == 1) {
                } else {
                  setState(() {
                    stage = stage == 3 ? 2 : 1;
                  });
                }
              },
              text: LocalizationService.translateFromGeneral('goBack'),
              icon: Icons.west,
              iconAlignment: IconAlignment.end,
              width: Get.width * 0.42,
              fontSize: 14,
              textColor: Palette.mainAppColorNavy,
              iconColor: Palette.mainAppColorNavy,
              backgroundColor: Palette.mainAppColorWhite,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildImageStack() {
    return Stack(
      children: [
        // _buildImage(Assets.signOne),
        _buildImage(Assets.ironFitLogo),
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
}
