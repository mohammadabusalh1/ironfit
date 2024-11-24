import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/controllers/sharedPreferences.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/Button.dart';
import 'package:ironfit/core/presentation/widgets/CheckTockens.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';
import 'package:ironfit/core/presentation/widgets/customSnackbar.dart';
import 'package:ironfit/core/presentation/widgets/hederImage.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';
import 'package:ironfit/core/presentation/widgets/theme.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:ironfit/features/PaymentPage/PaymentPage.dart';
import 'package:ironfit/features/coachProfile/controllers/coach_profile_controller.dart';
import 'package:ironfit/features/editPlan/widgets/BuildTextField.dart';
import 'package:ironfit/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoachProfileBody extends StatefulWidget {
  const CoachProfileBody({super.key});

  @override
  _CoachProfileBodyState createState() => _CoachProfileBodyState();
}

class _CoachProfileBodyState extends State<CoachProfileBody> {
  final CoachProfileController controller = Get.find();

  PreferencesService preferencesService = PreferencesService();
  TokenService tokenService = TokenService();
  CustomSnackbar customSnackbar = CustomSnackbar();
  late String dir;

  @override
  void initState() {
    super.initState();
    tokenService.checkTokenAndNavigateSingIn();
    if (!controller.profileData.value.isDataLoaded) {
      controller.fetchUserName();
    }
    dir = LocalizationService.getDir();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void changeUserImage() async {
    await controller.changeUserImage();
  }

  void showEditInfoDialog(BuildContext context) {
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
                    child: Text(
                        LocalizationService.translateFromGeneral('cancel')),
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

  void showEditPasswordDialog(BuildContext context) {
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
              textDirection:
                  dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
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
                          onChange: (value) =>
                              oldPasswordController.text = value,
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
                          onChange: (value) =>
                              newPasswordController.text = value,
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                HeaderImage(
                  headerImage: Assets.header2,
                  high: MediaQuery.of(context).size.height * 0.41,
                  borderRadius: 32,
                  width: MediaQuery.of(context).size.width * 0.99,
                ),
                _buildProfileContent(context),
              ],
            ),
            SizedBox(height: 10),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        textAlign: TextAlign.start,
                        LocalizationService.translateFromGeneral('profile'),
                        style: AppStyles.textCairo(
                          20,
                          Palette.mainAppColorWhite,
                          FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    _buildButtonCard(
                        context,
                        LocalizationService.translateFromGeneral(
                            'personalInformation'),
                        Icons.person_2, () {
                      showEditInfoDialog(context);
                    }, Icons.arrow_forward_ios_outlined,
                        Palette.mainAppColorBack),
                    _buildButtonCard(
                        context,
                        LocalizationService.translateFromGeneral(
                            'communicateWithTrainees'),
                        Icons.chat, () {
                      Get.toNamed(Routes.chat);
                    }, Icons.arrow_forward_ios_outlined,
                        Palette.mainAppColorBack),
                    _buildButtonCard(
                        context,
                        LocalizationService.translateFromGeneral(
                            'changePassword'),
                        Icons.password_outlined, () {
                      showEditPasswordDialog(context);
                    }, Icons.arrow_forward_ios_outlined,
                        Palette.mainAppColorBack),
                    SizedBox(height: 16),
                    _buildButtonCard(
                        context,
                        LocalizationService.translateFromGeneral(
                            'subscription'),
                        Icons.workspace_premium, () {
                      _showSubscriptionDialog(context);
                    }, Icons.arrow_forward_ios, Palette.mainAppColorOrange),
                    // _buildButtonCard(
                    //     context,
                    //     LocalizationService.translateFromGeneral('gyms'),
                    //     Icons.location_on, () {
                    //   Get.toNamed(Routes.myGyms);
                    // }, Icons.arrow_forward_ios, Palette.mainAppColorOrange),
                    _buildButtonCard(
                        context,
                        dir == 'rtl'
                            ? LocalizationService.translateFromPage(
                                'English', 'selectLang')
                            : LocalizationService.translateFromPage(
                                'Arabic', 'selectLang'),
                        Icons.translate, () {
                      LocalizationService.load(
                          LocalizationService.lang == 'en' ? 'ar' : 'en');
                      RestartWidget.restartApp(context);
                      Navigator.pushNamed(context, Routes.coachProfile);
                    }, Icons.arrow_forward_ios, Palette.mainAppColorOrange),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context) {
    return Align(
      child: Column(
        children: [
          InkWell(
            child: _buildProfileImage(),
            onTap: changeUserImage,
          ),
          const SizedBox(height: 12),
          Obx(() => Text(
                controller.profileData.value.fullName ??
                    LocalizationService.translateFromGeneral('noName'),
                style: AppStyles.textCairo(
                  22,
                  Palette.mainAppColorWhite,
                  FontWeight.bold,
                ),
              )),
          Obx(() => Text(
                controller.profileData.value.email,
                style: AppStyles.textCairo(
                  12,
                  Palette.subTitleGrey,
                  FontWeight.w100,
                ),
              )),
          const SizedBox(height: 12),
          BuildIconButton(
            backgroundColor: Palette.mainAppColorWhite,
            textColor: Palette.redDelete,
            fontSize: 12,
            text: LocalizationService.translateFromGeneral('logout'),
            onPressed: () {
              _logout();
            },
          )
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return Obx(() => Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: SizedBox(
                width: 88,
                height: 88,
                child: controller.profileData.value.imageUrl.startsWith('http')
                    ? CachedNetworkImage(
                        imageUrl: controller.profileData.value.imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            Image.asset(Assets.notFound),
                      )
                    : controller.profileData.value.imageUrl.startsWith('/')
                        ? Image.file(
                            File(controller.profileData.value.imageUrl),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(Assets.notFound),
                          )
                        : Image.asset(Assets.notFound),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Palette.mainAppColorOrange,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Palette.mainAppColorWhite,
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: Palette.mainAppColorWhite,
                  size: 14,
                ),
              ),
            ),
          ],
        ));
  }

  Widget _buildButtonCard(BuildContext context, String tilte, IconData icon,
      VoidCallback onClick, IconData? leftIcon, Color? IconBackColor) {
    return InkWell(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: IconBackColor ?? Palette.mainAppColorBack,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                icon,
                color: Palette.mainAppColorWhite,
                size: 18,
              ),
            ),
            const SizedBox(width: 12), // Space between icon and text
            Text(
              tilte,
              style: AppStyles.textCairo(
                14,
                Palette.mainAppColorWhite,
                FontWeight.normal,
              ),
            ),
            const Spacer(), // Space between text and trailing icon
            Icon(
              leftIcon,
              color: Palette.gray
                  .withOpacity(0.8), // Replace with the theme color if needed
              size: 14,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      SharedPreferences prefs = await preferencesService.getPreferences();

      prefs.remove('userId');
      prefs.remove('token');
      prefs.remove('isCoach');
      Get.toNamed(Routes.singIn);
    } catch (e) {
      customSnackbar.showMessage(
          context, LocalizationService.translateFromGeneral('logoutError'));
    }
  }

  void _showSubscriptionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: customThemeData,
          child: Directionality(
            textDirection: dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
            child: AlertDialog(
              title: Text(
                LocalizationService.translateFromGeneral('premiumSubscription'),
                style: AppStyles.textCairo(
                  22,
                  Palette.mainAppColorWhite,
                  FontWeight.bold,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '\$20/${LocalizationService.translateFromGeneral('month')}',
                    style: AppStyles.textCairo(
                      32,
                      Palette.mainAppColorOrange,
                      FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildBenefitRow(
                      Icons.check_circle,
                      LocalizationService.translateFromGeneral(
                          'unlimitedTrainees')),
                  _buildBenefitRow(
                      Icons.check_circle,
                      LocalizationService.translateFromGeneral(
                          'prioritySupport')),
                  _buildBenefitRow(
                      Icons.check_circle,
                      LocalizationService.translateFromGeneral(
                          'advancedAnalytics')),
                  const SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Palette.mainAppColorBack.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocalizationService.translateFromGeneral(
                              'paymentDetails'),
                          style: AppStyles.textCairo(
                            16,
                            Palette.mainAppColorWhite,
                            FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              LocalizationService.translateFromGeneral(
                                  'amount'),
                              style: AppStyles.textCairo(
                                14,
                                Palette.mainAppColorWhite,
                                FontWeight.normal,
                              ),
                            ),
                            Text(
                              '\$20.00',
                              style: AppStyles.textCairo(
                                14,
                                Palette.mainAppColorWhite,
                                FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  BuildIconButton(
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PaymentPage())),
                    text:
                        LocalizationService.translateFromGeneral('payWithCard'),
                    width: double.infinity,
                    backgroundColor: Palette.mainAppColorOrange,
                    icon: Icons.credit_card,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBenefitRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Palette.mainAppColorOrange, size: 20),
          const SizedBox(width: 12),
          Text(
            text,
            style: AppStyles.textCairo(
              14,
              Palette.mainAppColorWhite,
              FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
