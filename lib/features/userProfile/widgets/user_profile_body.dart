import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
import 'package:ironfit/features/editPlan/widgets/BuildTextField.dart';
import 'package:ironfit/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileBody extends StatefulWidget {
  const UserProfileBody({super.key});

  @override
  _UserProfileBodyState createState() => _UserProfileBodyState();
}

class _UserProfileBodyState extends State<UserProfileBody> {
  String? fullName;
  String trainerImage = Assets.notFound;
  bool isDataLoaded = false;
  PreferencesService preferencesService = PreferencesService();
  String numberOfDays = '0';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TokenService tokenService = TokenService();
  CustomSnackbar customSnackbar = CustomSnackbar();
  late String dir;
  bool isLoading = false;
  bool _isImageUploading = false;
  bool _isDataFetching = false;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    setState(() => _isDataFetching = true);
    try {
      await Future.wait([
        tokenService.checkTokenAndNavigateSingIn(),
        fetchUserDays(),
        fetchUserName(),
      ]);
    } finally {
      setState(() => _isDataFetching = false);
    }
    dir = LocalizationService.getDir();
  }

  Future<void> fetchUserDays() async {
    try {
      String? userId = _auth.currentUser?.uid;
      // Attempt to fetch user document
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('trainees')
          .doc(userId)
          .get();

      // Check if the user document exists
      if (!userDoc.exists) {
        throw Exception('User document does not exist');
      }

      var subscription = await FirebaseFirestore.instance
          .collection('subscriptions')
          .where('userId', isEqualTo: userId)
          .get();

      if (subscription.docs.isEmpty) {
        setState(() {
          numberOfDays = '-0';
        });
        return;
      }

      DocumentSnapshot subscriptionDoc = subscription.docs.first;

      // Check if the subscription document exists
      if (!subscriptionDoc.exists) {
        throw Exception('Subscription document does not exist');
      }

      setState(() {
        numberOfDays = DateTime.parse(subscriptionDoc['endDate'])
            .difference(DateTime.now())
            .inDays
            .toString();
      });
    } catch (error) {
      // Handle errors appropriately
      print('Error fetching user days: $error');
      setState(() {
        numberOfDays =
            'Error: ${error.toString()}'; // Optionally show the error message
      });
      // Optionally show a user-friendly message using a SnackBar or AlertDialog
    }
  }

  Future<void> fetchUserName() async {
    try {
      String? userId = _auth.currentUser?.uid;
      if (userId == null) throw Exception('No user logged in');

      final userDoc = await FirebaseFirestore.instance
          .collection('trainees')
          .doc(userId)
          .get();

      if (!userDoc.exists) throw Exception('User data not found');

      final userData = userDoc.data() as Map<String, dynamic>;
      
      setState(() {
        fullName = userData['firstName'] as String?;
        trainerImage = userData['profileImageUrl'] ?? Assets.notFound;
        isDataLoaded = true;
      });
    } catch (e) {
      customSnackbar.showFailureMessage(context);
      setState(() => isDataLoaded = false);
    }
  }

  void showEditInfoDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>(); // Form validation key
    final TextEditingController firstNameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();
    final TextEditingController ageController = TextEditingController();
    final TextEditingController wightController = TextEditingController();
    final TextEditingController heightController = TextEditingController();

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
                      22, Palette.mainAppColorWhite, FontWeight.bold),
                ),
                content: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BuildTextField(
                        dir: dir,
                        controller: firstNameController,
                        label: LocalizationService.translateFromGeneral(
                            'firstNameLabel'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return LocalizationService.translateFromGeneral(
                                'firstNameError');
                          }
                          return null;
                        },
                        icon: Icons.person_2_outlined,
                      ),
                      const SizedBox(height: 16),
                      BuildTextField(
                        dir: dir,
                        controller: lastNameController,
                        label: LocalizationService.translateFromGeneral(
                            'lastNameLabel'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return LocalizationService.translateFromGeneral(
                                'lastNameError ');
                          }
                          return null;
                        },
                        icon: Icons.person_2_outlined,
                      ),
                      const SizedBox(height: 16),
                      BuildTextField(
                        dir: dir,
                        controller: ageController,
                        label: LocalizationService.translateFromGeneral('age'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return LocalizationService.translateFromGeneral(
                                LocalizationService.translateFromGeneral(
                                    'ageError'));
                          }
                          if (int.tryParse(value) == null) {
                            return LocalizationService.translateFromGeneral(
                                'ageError');
                          }
                          return null;
                        },
                        icon: Icons.cake_outlined,
                      ),
                      const SizedBox(height: 16),
                      BuildTextField(
                        dir: dir,
                        controller: wightController,
                        keyboardType: TextInputType.number,
                        label:
                            LocalizationService.translateFromGeneral('weight'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return LocalizationService.translateFromGeneral(
                                'weightError');
                          }
                          return null;
                        },
                        icon: Icons.scale_outlined,
                      ),
                      const SizedBox(height: 16),
                      BuildTextField(
                        dir: dir,
                        controller: heightController,
                        keyboardType: TextInputType.number,
                        label:
                            LocalizationService.translateFromGeneral('height'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return LocalizationService.translateFromGeneral(
                                'heightError');
                          }
                          return null;
                        },
                        icon: Icons.height_outlined,
                      ),
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState?.validate() ?? false) {
                        final FirebaseAuth auth = FirebaseAuth.instance;
                        String? userId = auth.currentUser?.uid;
                        try {
                          if (userId != null) {
                            await FirebaseFirestore.instance
                                .collection('trainees')
                                .doc(userId)
                                .update({
                              'firstName': firstNameController.text,
                              'lastName': lastNameController.text,
                              'age': ageController.text,
                              'weight': wightController.text,
                              'height': heightController.text
                            }).then((value) {
                              fetchUserName();
                            });
                            Navigator.of(context).pop();
                          }
                        } catch (e) {
                          // Handle errors (e.g., network issues, Firebase errors)
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  '${LocalizationService.translateFromGeneral('unexpectedError')} $e')));
                        }
                      }
                    },
                    child: Text(
                      LocalizationService.translateFromGeneral('save'),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Text(
                      LocalizationService.translateFromGeneral('cancel'),
                    ),
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
                        22, Palette.mainAppColorWhite, FontWeight.bold),
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
                            style: AppStyles.textCairo(14,
                                Palette.mainAppColorWhite, FontWeight.w500)),
                        const SizedBox(height: 16),
                        BuildTextField(
                          dir: dir,
                          obscureText: true,
                          controller: oldPasswordController,
                          label: LocalizationService.translateFromGeneral(
                              'oldPassword'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجى إدخال كلمة المرور القديمة';
                            }
                            return null;
                          },
                          icon: Icons.password,
                        ),
                        const SizedBox(height: 16),
                        BuildTextField(
                          dir: dir,
                          obscureText: true,
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
                    ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState?.validate() ?? false) {
                          try {
                            User? user = FirebaseAuth.instance.currentUser;
                            if (user != null) {
                              // Re-authenticate user to change password
                              final AuthCredential credential =
                                  EmailAuthProvider.credential(
                                email: user.email!,
                                password: oldPasswordController.text,
                              );
                              await user
                                  .reauthenticateWithCredential(credential);

                              // Update password
                              await user
                                  .updatePassword(newPasswordController.text);

                              // Inform the user
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(LocalizationService
                                        .translateFromGeneral(
                                            'passwordChangeSuccess'))),
                              );

                              Navigator.of(context).pop(); // Close the dialog
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      '${LocalizationService.translateFromGeneral('unexpectedError')} ${e.toString()}')),
                            );
                          }
                        }
                      },
                      child: Text(
                          LocalizationService.translateFromGeneral('save')),
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
    if (_isDataFetching) {
      return const Center(child: CircularProgressIndicator());
    }

    return SafeArea(
      top: true,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(context),
            const SizedBox(height: 24),
            _buildSettingsSection(context),
          ],
        ),
      ),
    );
  }

  Future<void> changeUserImage() async {
    if (_isImageUploading) return;

    try {
      setState(() => _isImageUploading = true);
      
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );

      if (pickedFile == null) return;

      final File imageFile = File(pickedFile.path);
      final String userId = _auth.currentUser!.uid;
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images/$userId.jpg');

      // Update UI with local image first
      setState(() => trainerImage = pickedFile.path);

      // Upload and get URL
      final uploadTask = storageRef.putFile(
        imageFile,
        SettableMetadata(contentType: 'image/jpeg'),
      );

      final downloadUrl = await (await uploadTask).ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('trainees')
          .doc(userId)
          .update({'profileImageUrl': downloadUrl});

      setState(() => trainerImage = downloadUrl);
      
      customSnackbar.showMessage(
        context,
        LocalizationService.translateFromGeneral('imageUploadSuccess'),
      );
    } catch (e) {
      customSnackbar.showFailureMessage(context);
    } finally {
      setState(() => _isImageUploading = false);
    }
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Stack(
      children: [
        HeaderImage(
          headerImage: Assets.header2,
          high: MediaQuery.of(context).size.height * 0.41,
          borderRadius: 32,
          width: MediaQuery.of(context).size.width * 0.99,
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.04,
          left: 24,
          right: 24,
          height: MediaQuery.of(context).size.height * 0.41,
          child: _buildProfileContent(context),
        )
      ],
    );
  }

  Widget _buildProfileContent(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        children: [
          InkWell(
            onTap: changeUserImage,
            child: _buildProfileImage(),
          ),
          const SizedBox(height: 8),
          Text(
            fullName ?? LocalizationService.translateFromGeneral('noName'),
            style: AppStyles.textCairo(
              22,
              Palette.mainAppColorWhite,
              FontWeight.bold,
            ),
          ),
          // Text(
          //   trainerEmail,
          //   style: AppStyles.textCairo(
          //     12,
          //     Palette.subTitleGrey,
          //     FontWeight.w100,
          //   ),
          // ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Palette.mainAppColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.access_time,
                  color: Palette.mainAppColor,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  '${LocalizationService.translateFromGeneral('remainingDays')}: $numberOfDays ${LocalizationService.translateFromGeneral('daysAgo')}',
                  style: AppStyles.textCairo(
                    14,
                    Palette.mainAppColor,
                    FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
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

  Widget _buildSettingsSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildButtonCard(
            context,
            LocalizationService.translateFromGeneral(
                'personalInformation'),
            Icons.settings,
            () => showEditInfoDialog(context),
            Icons.arrow_forward_ios_outlined,
            Palette.mainAppColor,
          ),
          _buildButtonCard(
            context,
            LocalizationService.translateFromGeneral(
                'changePassword'),
            Icons.lock,
            () => showEditPasswordDialog(context),
            Icons.arrow_forward_ios_outlined,
            Palette.mainAppColor,
          ),
          _buildButtonCard(
            context,
            LocalizationService.translateFromGeneral('gyms'),
            Icons.location_on,
            () => Get.toNamed(Routes.myGyms),
            Icons.arrow_forward_ios,
            Palette.mainAppColor,
          ),
          _buildButtonCard(
            context,
            dir == 'rtl'
                ? LocalizationService.translateFromPage(
                    'English', 'selectLang')
                : LocalizationService.translateFromPage(
                    'Arabic', 'selectLang'),
            Icons.translate,
            () {
              LocalizationService.load(
                LocalizationService.lang == 'en' ? 'ar' : 'en',
              );
              RestartWidget.restartApp(context);
              Navigator.pushNamed(context, Routes.userProfile);
            },
            Icons.arrow_forward_ios,
            Palette.mainAppColor,
          ),
        ],
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
      customSnackbar.showFailureMessage(context);
    }
  }

  Widget _buildProfileImage() {
    return Stack(
      children: [
        // Profile Image
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: SizedBox(
            width: 88,
            height: 88,
            child: trainerImage.startsWith('http')
                ? CachedNetworkImage(
                    imageUrl: trainerImage,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        Image.asset(Assets.notFound),
                  )
                : trainerImage.startsWith('/')
                    ? Image.file(
                        File(trainerImage),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(Assets.notFound),
                      )
                    : Image.asset(Assets.notFound),
          ),
        ),

        // Camera Icon Flag
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Palette.mainAppColor,
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
    );
  }

  Widget _buildButtonCard(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onClick,
    IconData? trailingIcon,
    Color? iconBackColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onClick,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Palette.mainAppColorWhite.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Palette.mainAppColorWhite.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: iconBackColor ?? Palette.mainAppColorWhite,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: AppStyles.textCairo(
                      12,
                      Palette.mainAppColorWhite,
                      FontWeight.w500,
                    ),
                  ),
                ),
                Icon(
                  trailingIcon ?? Icons.arrow_forward_ios,
                  color: Palette.mainAppColorWhite.withOpacity(0.5),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
