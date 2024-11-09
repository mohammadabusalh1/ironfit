import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_picker/image_picker.dart';
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
import 'package:ironfit/features/coachProfile/controllers/coach_profile_controller.dart';
import 'package:ironfit/features/editPlan/widgets/BuildTextField.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? fullName;
String imageUrl =
    'https://cdn.vectorstock.com/i/500p/30/21/data-search-not-found-concept-vector-36073021.jpg';
String email = '';

class CoachProfileBody extends StatefulWidget {
  const CoachProfileBody({super.key});

  @override
  _CoachProfileBodyState createState() => _CoachProfileBodyState();
}

class _CoachProfileBodyState extends State<CoachProfileBody> {
  final CoachProfileController controller = Get.find();
  bool isLoading = true;
  String coachId = FirebaseAuth.instance.currentUser!.uid;
  bool isDataLoaded = false;

  PreferencesService preferencesService = PreferencesService();
  TokenService tokenService = TokenService();
  CustomSnackbar customSnackbar = CustomSnackbar();

  late BannerAd bannerAd;
  bool isBannerAdLoaded = false;

  @override
  void initState() {
    super.initState();
    tokenService.checkTokenAndNavigateSingIn();
    bannerAd = BannerAd(
        adUnitId: 'ca-app-pub-2914276526243261/3277263040',
        size: AdSize.banner,
        request: const AdRequest(),
        listener: BannerAdListener(onAdLoaded: (ad) {
          setState(() {
            isBannerAdLoaded = true;
          });
        }, onAdFailedToLoad: (ad, error) {
          ad.dispose();
        }));
    bannerAd.load();
    if (!isDataLoaded) {
      fetchUserName();
      setState(() {
        isDataLoaded = true;
      });
    }
  }

  @override
  void dispose() {
    bannerAd.dispose();
    super.dispose();
  }

  Future<void> changeUserImage() async {
    final ImagePicker picker = ImagePicker();

    // Pick an image from the gallery
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        isLoading = true;
      });

      try {
        try {
          Get.dialog(const Center(child: CircularProgressIndicator()),
              barrierDismissible: false);
          final storageRef = FirebaseStorage.instance.ref().child(
              'profile_images/${FirebaseAuth.instance.currentUser!.uid}.jpg');
          await storageRef.putFile(File(pickedFile.path)).then(
            (snapshot) {
              customSnackbar.showMessage(
                  context,
                  LocalizationService.translateFromGeneral(
                      'imageUploadSuccess'));
            },
          );
          final downloadUrl = await storageRef.getDownloadURL();

          setState(() {
            imageUrl = downloadUrl;
          });

          await FirebaseFirestore.instance
              .collection('coaches')
              .doc(coachId)
              .update({
            'profileImageUrl': downloadUrl,
          });

          setState(() {
            imageUrl = downloadUrl;
            isLoading = false;
          });

          Get.back();
        } catch (e) {
          Get.back();
          customSnackbar.showFailureMessage(context);
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        customSnackbar.showFailureMessage(context);
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchUserName() async {
    try {
      tokenService.checkTokenAndNavigateSingIn();
      // Get user data from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('coaches')
          .doc(coachId)
          .get();

      if (userDoc.exists) {
        String? firstName = userDoc['firstName'];
        String? lastName = userDoc['lastName'];

        setState(() {
          fullName = '$firstName $lastName';
          email = userDoc['email'] ?? ''; // Ensure to handle null safely
          imageUrl =
              userDoc['profileImageUrl'] ?? ''; // Ensure to handle null safely
        });
      } else {
        // Handle case where document does not exist
        print("User data not found for coach ID: $coachId");
        // Perform fallback action or show appropriate message
      }
    } catch (e) {
      // Handle specific exceptions
      print("Error fetching user data: $e");
      // Perform appropriate error handling actions, e.g., show error message
    }
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
            await FirebaseFirestore.instance
                .collection('coaches')
                .doc(coachId)
                .update(updateData)
                .then((_) {
              fetchUserName();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            });
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
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              const HeaderImage(),
              _buildProfileContent(context),
            ],
          ),
          const SizedBox(height: 24),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isBannerAdLoaded
                          ? SizedBox(
                              child: AdWidget(ad: bannerAd),
                              height: bannerAd.size.height.toDouble(),
                              width: bannerAd.size.width.toDouble(),
                            )
                          : const SizedBox(),
                      const SizedBox(height: 12),
                      _buildButtonCard(
                          context,
                          LocalizationService.translateFromGeneral(
                              'personalInformation'),
                          Icons.person, () {
                        showEditInfoDialog(context);
                      }, Icons.arrow_forward_ios_outlined),
                      _buildButtonCard(
                          context,
                          LocalizationService.translateFromGeneral(
                              'changePassword'),
                          Icons.vpn_key, () {
                        showEditPasswordDialog(context);
                      }, Icons.arrow_forward_ios_outlined),
                      _buildButtonCard(
                          context,
                          LocalizationService.translateFromGeneral('gyms'),
                          Icons.location_on, () {
                        Get.toNamed(Routes.myGyms);
                      }, Icons.arrow_forward_ios_outlined),
                      _buildButtonCard(
                          context,
                          LocalizationService.translateFromGeneral('logout'),
                          Icons.logout_outlined, () {
                        _logout();
                      }, Icons.arrow_forward_ios_outlined),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context) {
    return Align(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(Get.context!).size.height * 0.12),
          Container(
            width: 104, // Add extra width to accommodate the border
            height: 104, // Add extra height to accommodate the border
            decoration: BoxDecoration(
              border: Border.all(
                color: Palette.black, // Replace with your desired border color
                width: 4.0, // Border width
              ),
              borderRadius:
                  BorderRadius.circular(50), // Same as ClipRRect borderRadius
            ),
            child: InkWell(
              onTap: changeUserImage,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: imageUrl.isEmpty
                    ? const CircularProgressIndicator() // Show loading indicator if image is empty
                    : Image.network(
                        imageUrl.isEmpty ? Assets.notFound : imageUrl,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null,
                              ),
                            );
                          }
                        },
                      ),
              ),
            ),
          ),

          const SizedBox(height: 10),
          // Use FutureBuilder to display the fetched user name
          Text(
            fullName ??
                LocalizationService.translateFromGeneral(
                    'noName'), // If no name, display a default message
            style: AppStyles.textCairo(
              20,
              Palette.mainAppColorWhite,
              FontWeight.w600,
            ),
          ),
          Text(
            email, // If no name, display a default message
            style: AppStyles.textCairo(
              14,
              Palette.subTitleGrey,
              FontWeight.w100,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonCard(BuildContext context, String tilte, IconData icon,
      VoidCallback onClick, IconData leftIcon) {
    return InkWell(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Palette.white,
              size: 32,
            ),
            const SizedBox(width: 24), // Space between icon and text
            Text(
              tilte,
              style: AppStyles.textCairo(
                14,
                Palette.mainAppColorWhite,
                FontWeight.w500,
              ),
            ),
            const Spacer(), // Space between text and trailing icon
            Icon(
              leftIcon,
              color: Colors.grey, // Replace with the theme color if needed
              size: 16,
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
      prefs.clear();
      Get.toNamed(Routes.selectEnter);
    } catch (e) {
      customSnackbar.showMessage(
          context, LocalizationService.translateFromGeneral('logoutError'));
    }
  }
}
