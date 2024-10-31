import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/controllers/sharedPreferences.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/Button.dart';
import 'package:ironfit/core/presentation/widgets/CheckTockens.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';
import 'package:ironfit/core/presentation/widgets/customSnackbar.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';
import 'package:ironfit/core/presentation/widgets/uploadImage.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:ironfit/features/editPlan/widgets/BuildTextField.dart';

class CoachEnterInfoBody extends StatefulWidget {
  CoachEnterInfoBody({Key? key}) : super(key: key);

  @override
  _CoachEnterInfoBodyState createState() => _CoachEnterInfoBodyState();
}

class _CoachEnterInfoBodyState extends State<CoachEnterInfoBody> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _usernameController =
      TextEditingController(); // Added username controller

  String? _uploadedImageUrl;
  int stage = 1;
  String coachId = FirebaseAuth.instance.currentUser!.uid;

  PreferencesService preferencesService = PreferencesService();
  TokenService tokenService = TokenService();
  CustomSnackbar customSnackbar = CustomSnackbar();

  @override
  void initState() {
    super.initState();
    tokenService.checkTokenAndNavigateSingIn();
  }

  Future<void> updateCoachInfo(
      String coachId, Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance
          .collection('coaches')
          .doc(coachId)
          .update(data);
      // Success handling, if needed
    } catch (e) {
      // Error handling
      print('Error updating coach info: $e');
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
          Get.dialog(const Center(child: CircularProgressIndicator()),
              barrierDismissible: false);
          String username = _usernameController.text;
          String firstName = _firstNameController.text;
          String lastName = _lastNameController.text;
          String age = _ageController.text;
          String experience = _experienceController.text;

          // Check if username exists in the database
          bool usernameExists = await _checkIfUsernameExists(username);

          if (usernameExists) {
            customSnackbar.showDoesNotExistMessage(context);
            return;
          }

          Map<String, dynamic> coachData = {
            'firstName': firstName,
            'lastName': lastName,
            'age': int.parse(age),
            'experience': int.parse(experience),
            'profileImageUrl': _uploadedImageUrl,
            'username': username,
          };

          await updateCoachInfo(coachId, coachData).then(
            (value) {
              customSnackbar.showSuccessMessage(context);
              Get.toNamed(Routes.coachDashboard)?.then(
                (value) => Get.back(),
              );
            },
          );
        }
        // Navigate to the next page or perform any other action
      } on FirebaseException {
        Get.back();
        customSnackbar.showFailureMessage(context);
      } on FormatException {
        Get.back();
        // Handle invalid number format (e.g., age or experience)
        customSnackbar.showInvalidFormatMessage(context);
      } catch (e) {
        Get.back();
        customSnackbar.showFailureMessage(context);
      }
    } else {
      customSnackbar.showInvalidFormatMessage(context);
    }
  }

  String? validator(value) {
    if (value!.isEmpty) {
      return LocalizationService.translateFromGeneral('thisFieldRequired');
    }
    return null;
  }

  // Function to check if username exists in the database
  Future<bool> _checkIfUsernameExists(String username) async {
    try {
      // Example query to check if the username exists in Firestore
      var snapshot = await FirebaseFirestore.instance
          .collection('coaches')
          .where('username', isEqualTo: username)
          .get();

      // If snapshot contains documents, username exists
      return snapshot.docs.isNotEmpty;
    } catch (e) {
      customSnackbar.showFailureMessage(context);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImageStack(),
                stage == 2 ? const SizedBox(height: 24) : Container(),
                stage == 2
                    ? ImagePickerComponent(
                        userId: coachId,
                        onImageUploaded: (imageUrl) {
                          setState(() {
                            _uploadedImageUrl = imageUrl;
                          });
                        })
                    : Container(),
                const SizedBox(height: 12),
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
                              FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                    : Container(),
                stage == 1 ? const SizedBox(height: 12) : Container(),
                stage == 1
                    ? Text(LocalizationService.translateFromGeneral('account'),
                        style: AppStyles.textCairo(
                          16,
                          Palette.mainAppColorWhite,
                          FontWeight.bold,
                        ))
                    : Container(),
                stage == 1 ? const SizedBox(height: 12) : Container(),
                stage == 1
                    ? BuildTextField(
                        onChange: (value) {
                          setState(() {
                            _usernameController.text = value;
                          });
                        },
                        label: LocalizationService.translateFromGeneral(
                            'usernameLabel'),
                        controller: _usernameController,
                        keyboardType: TextInputType.text,
                        icon: Icons.person,
                        validator: validator)
                    : Container(),
                stage == 1 ? const SizedBox(height: 12) : Container(),
                stage == 1
                    ? BuildTextField(
                        onChange: (value) {
                          setState(() {
                            _firstNameController.text = value;
                          });
                        },
                        label: LocalizationService.translateFromGeneral(
                            'firstNameLabel'),
                        controller: _firstNameController,
                        keyboardType: TextInputType.text,
                        icon: Icons.face,
                        validator: validator)
                    : Container(),
                stage == 1 ? const SizedBox(height: 12) : Container(),
                stage == 1
                    ? BuildTextField(
                        onChange: (value) {
                          setState(() {
                            _lastNameController.text = value;
                          });
                        },
                        label: LocalizationService.translateFromGeneral(
                            'lastNameLabel'),
                        controller: _lastNameController,
                        keyboardType: TextInputType.text,
                        icon: Icons.face,
                        validator: validator)
                    : Container(),
                stage == 1 ? const SizedBox(height: 12) : Container(),
                stage == 1
                    ? const Divider(
                        color: Palette.gray,
                      )
                    : Container(),
                stage == 1 ? const SizedBox(height: 12) : Container(),
                stage == 1
                    ? Text(
                        LocalizationService.translateFromGeneral(
                            'personalInformation'),
                        style: AppStyles.textCairo(
                          16,
                          Palette.mainAppColorWhite,
                          FontWeight.w600,
                        ),
                      )
                    : Container(),
                stage == 1 ? const SizedBox(height: 12) : Container(),
                stage == 1
                    ? BuildTextField(
                        onChange: (value) {
                          setState(() {
                            _ageController.text = value;
                          });
                        },
                        label: LocalizationService.translateFromGeneral('age'),
                        controller: _ageController,
                        keyboardType: TextInputType.number,
                        icon: Icons.group,
                        validator: validator)
                    : Container(),
                stage == 1 ? const SizedBox(height: 12) : Container(),
                stage == 1
                    ? BuildTextField(
                        onChange: (value) {
                          setState(() {
                            _experienceController.text = value;
                          });
                        },
                        label: LocalizationService.translateFromGeneral(
                            'experience'),
                        controller: _experienceController,
                        keyboardType: TextInputType.number,
                        icon: Icons.star,
                        validator: validator)
                    : Container(),
                stage == 1 ? const SizedBox(height: 24) : Container(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: BuildIconButton(
          onPressed: _submitForm,
          text: LocalizationService.translateFromGeneral('next'),
          icon: Icons.west,
          iconAlignment: IconAlignment.end,
        ),
      ),
    );
  }

  Widget _buildImageStack() {
    return Stack(
      children: [
        _buildImage('assets/images/signOne.jpeg'),
        _buildImage('assets/images/IronFit.png'),
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

  OutlineInputBorder _buildInputBorder(Color borderColor) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: borderColor, width: 1),
      borderRadius: BorderRadius.circular(10),
    );
  }
}
