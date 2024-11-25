import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/Button.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';
import 'package:ironfit/core/presentation/widgets/customSnackbar.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';
import 'package:ironfit/core/presentation/widgets/theme.dart';
import 'package:ironfit/features/coachProfile/controllers/coach_profile_controller.dart';
import 'package:ironfit/features/editPlan/widgets/BuildTextField.dart';

void showEditInfoDialog(BuildContext context, String dir,
    CoachProfileController controller, CustomSnackbar customSnackbar) {
  final formKey = GlobalKey<FormState>(); // Form validation key
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();

  Future<void> updateInfo() async {
    if (formKey.currentState?.validate() ?? false) {
      try {
        Get.dialog(
          const Center(child: CircularProgressIndicator()),
          barrierDismissible: false,
        );
        // Prepare update data based on controller values
        Map<String, dynamic> updateData = {};

        if (firstNameController.text.isNotEmpty) {
          updateData['firstName'] = firstNameController.text;
        }

        if (lastNameController.text.isNotEmpty) {
          updateData['lastName'] = lastNameController.text;
        }

        if (ageController.text.isNotEmpty) {
          updateData['age'] = ageController.text;
        }

        if (experienceController.text.isNotEmpty) {
          updateData['experience'] = experienceController.text;
        }

        // Perform Firestore update if there is any data to update
        if (updateData.isNotEmpty) {
          await controller.updateUserInfo(updateData);
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        } else {
          // Handle case where no fields were updated
          customSnackbar.showMessageAbove(context,
              LocalizationService.translateFromGeneral('NoFieldsToUpdate'));
        }
      } catch (e) {
        Navigator.of(context).pop();
        customSnackbar.showFailureMessage(context);
      }
    }
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Theme(
        data: customThemeData,
        child: Directionality(
          textDirection: dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
          child: SingleChildScrollView(
            child: AlertDialog(
              title: Text(
                LocalizationService.translateFromGeneral('editInfo'),
                style: AppStyles.textCairo(
                  22,
                  Palette.mainAppColorWhite,
                  FontWeight.bold,
                ),
              ),
              content: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BuildTextField(
                      dir: dir,
                      onChange: (firstName) {
                        firstNameController.text = firstName;
                      },
                      label: LocalizationService.translateFromGeneral(
                          'firstNameLabel'),
                      controller: firstNameController,
                      icon: Icons.person_2_outlined,
                    ),
                    const SizedBox(height: 16),
                    BuildTextField(
                      dir: dir,
                      onChange: (lastName) {
                        lastNameController.text = lastName;
                      },
                      label: LocalizationService.translateFromGeneral(
                          'lastNameLabel'),
                      controller: lastNameController,
                      icon: Icons.person_2_outlined,
                    ),
                    const SizedBox(height: 16),
                    BuildTextField(
                      dir: dir,
                      onChange: (age) {
                        ageController.text = age;
                      },
                      label: LocalizationService.translateFromGeneral('age'),
                      controller: ageController,
                      keyboardType: TextInputType.number,
                      icon: Icons.cake_outlined,
                    ),
                    const SizedBox(height: 16),
                    BuildTextField(
                      dir: dir,
                      onChange: (experience) {
                        experienceController.text = experience;
                      },
                      controller: experienceController,
                      keyboardType: TextInputType.number,
                      label: LocalizationService.translateFromGeneral(
                          'experience'),
                      icon: Icons.work_outline_outlined,
                    ),
                  ],
                ),
              ),
              actions: [
                BuildIconButton(
                  onPressed: updateInfo,
                  text: LocalizationService.translateFromGeneral('save'),
                  width: 100,
                  fontSize: 12,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child:
                      Text(LocalizationService.translateFromGeneral('cancel')),
                ),
              ],
              actionsAlignment: MainAxisAlignment.start,
            ),
          ),
        ),
      );
    },
  );
}

void showEditPasswordDialog(BuildContext context, String dir,
    CoachProfileController controller, CustomSnackbar customSnackbar) {
  final formKey = GlobalKey<FormState>();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Future<void> editPassword() async {
    if (formKey.currentState?.validate() ?? false) {
      try {
        Get.dialog(
          const Center(child: CircularProgressIndicator()),
          barrierDismissible: false,
        );

        if (newPasswordController.text != confirmPasswordController.text) {
          customSnackbar.showMessageAbove(context,
              LocalizationService.translateFromGeneral('passwordsDontMatch'));
          return;
        }

        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          // Re-authenticate user to change password
          final AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!,
            password: oldPasswordController.text,
          );
          await user.reauthenticateWithCredential(credential);

          // Update password
          await user.updatePassword(newPasswordController.text).then(
            (value) {
              Navigator.of(context).pop();
              customSnackbar.showMessageAbove(
                  context,
                  LocalizationService.translateFromGeneral(
                      'passwordChangeSuccess'));
            },
          );
          Navigator.of(context).pop();
        }
      } catch (e) {
        Navigator.of(context).pop();
        customSnackbar.showMessageAbove(context,
            LocalizationService.translateFromGeneral('invalidPassword'));
      }
    }
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Theme(
          data: customThemeData,
          child: Directionality(
            textDirection: dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
            child: SingleChildScrollView(
              child: AlertDialog(
                title: Text(
                  LocalizationService.translateFromGeneral('changePassword'),
                  style: AppStyles.textCairo(
                    22,
                    Palette.mainAppColorWhite,
                    FontWeight.bold,
                  ),
                ),
                content: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          LocalizationService.translateFromGeneral(
                              'pleaseFillRequiredData'),
                          style: AppStyles.textCairo(
                            14,
                            Palette.mainAppColorWhite,
                            FontWeight.w500,
                          )),
                      const SizedBox(height: 16),
                      BuildTextField(
                        dir: dir,
                        obscureText: true,
                        onChange: (value) => oldPasswordController.text = value,
                        controller: oldPasswordController,
                        label: LocalizationService.translateFromGeneral(
                            'oldPassword'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return LocalizationService.translateFromGeneral(
                                'oldPasswordError');
                          }
                          return null;
                        },
                        icon: Icons.password,
                      ),
                      const SizedBox(height: 16),
                      BuildTextField(
                        dir: dir,
                        obscureText: true,
                        onChange: (value) => newPasswordController.text = value,
                        controller: newPasswordController,
                        label: LocalizationService.translateFromGeneral(
                            'newPassword'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return LocalizationService.translateFromGeneral(
                                'newPasswordError');
                          }
                          if (value.length < 6) {
                            return LocalizationService.translateFromGeneral(
                                'newPasswordError2');
                          }
                          return null;
                        },
                        icon: Icons.lock_open,
                      ),
                      const SizedBox(height: 16),
                      BuildTextField(
                        dir: dir,
                        obscureText: true,
                        onChange: (value) =>
                            confirmPasswordController.text = value,
                        controller: confirmPasswordController,
                        label: LocalizationService.translateFromGeneral(
                            'confirmPassword'),
                        validator: (value) {
                          if (value != newPasswordController.text) {
                            return LocalizationService.translateFromGeneral(
                                'passwordsDontMatch');
                          }
                          return null;
                        },
                        icon: Icons.check_circle_outline,
                      ),
                    ],
                  ),
                ),
                actions: [
                  BuildIconButton(
                    onPressed: editPassword,
                    text: LocalizationService.translateFromGeneral('save'),
                    width: 100,
                    fontSize: 12,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Text(
                        LocalizationService.translateFromGeneral('cancel')),
                  ),
                ],
                actionsAlignment: MainAxisAlignment.start,
              ),
            ),
          ));
    },
  );
}
