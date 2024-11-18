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
import 'package:ironfit/features/dashboard/widgets/trainer_dashboard_body.dart';
import 'package:ironfit/features/editPlan/widgets/BuildTextField.dart';
import 'package:ironfit/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? fullName;
String trainerImage = Assets.notFound;
bool isDataLoaded = false;

class UserProfileBody extends StatefulWidget {
  const UserProfileBody({super.key});

  @override
  _UserProfileBodyState createState() => _UserProfileBodyState();
}

class _UserProfileBodyState extends State<UserProfileBody> {
  PreferencesService preferencesService = PreferencesService();
  String numberOfDays = '0';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TokenService tokenService = TokenService();
  CustomSnackbar customSnackbar = CustomSnackbar();
  late String dir;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    tokenService.checkTokenAndNavigateSingIn();
    fetchUserDays();
    fetchUserName();
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

      if (userId == null) {
        print("No user is logged in.");
        // Optionally, show a message to the user via UI here.
        return; // Early exit if the user is not logged in
      }
      // Get user data from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('trainees')
          .doc(userId)
          .get();

      if (!userDoc.exists) {
        print("User data not found for userId: $userId");
        // Optionally, notify the user about the missing data via UI
        return;
      }

      // Cast userDoc data to Map<String, dynamic>
      Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;

      // Retrieve user information safely
      String? firstName = userData?['firstName'];
      // String? lastName = userData?['lastName'];
      String profileImageUrl = userData?['profileImageUrl'] ?? Assets.notFound;

      setState(() {
        fullName = '$firstName';
        trainerImage = profileImageUrl;
      });
    } catch (e) {
      // Handle specific exceptions if needed, e.g., FirebaseException
      print("Error fetching user data: $e");
      // You can also show a user-friendly message on the UI
    } finally {
      setState(() {
        isDataLoaded = false;
      });
      print('isDataLoaded: $isDataLoaded');
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
    return SafeArea(
      top: true,
      child: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      HeaderImage(
                        headerImage: Assets.header2,
                        high: MediaQuery.of(context).size.height * 0.41,
                        borderRadius: 32,
                        width: MediaQuery.of(context).size.width * 0.99,
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.05,
                        left: 24,
                        right: 24,
                        height: MediaQuery.of(context).size.height * 0.41,
                        child: _buildProfileContent(context),
                      )
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildButtonCard(
                          context,
                          LocalizationService.translateFromGeneral('personalInformation'),
                          Icons.person_2,
                          () => showEditInfoDialog(context),
                          Icons.arrow_forward_ios_outlined,
                          Palette.mainAppColorBack,
                        ),
                        _buildButtonCard(
                          context,
                          LocalizationService.translateFromGeneral('changePassword'),
                          Icons.password_outlined,
                          () => showEditPasswordDialog(context),
                          Icons.arrow_forward_ios_outlined,
                          Palette.mainAppColorBack,
                        ),
                        _buildButtonCard(
                          context,
                          LocalizationService.translateFromGeneral('gyms'),
                          Icons.location_on,
                          () => Get.toNamed(Routes.myGyms),
                          Icons.arrow_forward_ios,
                          Palette.mainAppColorOrange,
                        ),
                        _buildButtonCard(
                          context,
                          dir == 'rtl'
                              ? LocalizationService.translateFromPage('English', 'selectLang')
                              : LocalizationService.translateFromPage('Arabic', 'selectLang'),
                          Icons.translate,
                          () {
                            LocalizationService.load(
                              LocalizationService.lang == 'en' ? 'ar' : 'en',
                            );
                            RestartWidget.restartApp(context);
                            Navigator.pushNamed(context, Routes.userProfile);
                          },
                          Icons.arrow_forward_ios,
                          Palette.mainAppColorOrange,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> changeUserImage() async {
    final ImagePicker picker = ImagePicker();

    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70, // Compress image quality to 70%
      );

      if (pickedFile == null) return;

      // Show loading indicator in a non-blocking way
      // Get.dialog(
      //   const Center(child: CircularProgressIndicator()),
      //   barrierDismissible: false,
      // );

      // Update UI immediately with local image
      setState(() {
        trainerImage = pickedFile.path;
        isLoading = true;
      });

      // Upload image in background
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images/${FirebaseAuth.instance.currentUser!.uid}.jpg');
      
      final uploadTask = storageRef.putFile(
        File(pickedFile.path),
        SettableMetadata(contentType: 'image/jpeg'),
      );

      // Listen to upload progress if needed
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        final progress = snapshot.bytesTransferred / snapshot.totalBytes;
        // You can use this progress value to show upload progress
      });

      // Wait for upload to complete and get download URL
      final downloadUrl = await (await uploadTask).ref.getDownloadURL();

      // Update Firestore with new image URL
      await FirebaseFirestore.instance
          .collection('trainees')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'profileImageUrl': downloadUrl,
      });

      // Update UI with cloud URL
      setState(() {
        trainerImage = downloadUrl;
        isLoading = false;
      });

      // Get.back(); // Remove loading dialog
      customSnackbar.showMessage(
        context,
        LocalizationService.translateFromGeneral('imageUploadSuccess'),
      );

    } catch (e) {
      Get.back(); // Remove loading dialog
      setState(() {
        isLoading = false;
      });
      customSnackbar.showFailureMessage(context);
    }
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
          Text(
            trainerEmail, // If no name, display a default message
            style: AppStyles.textCairo(
              12,
              Palette.subTitleGrey,
              FontWeight.w100,
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
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Palette.mainAppColoryellow2.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Palette.mainAppColorBack.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                // Leading Icon with background
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconBackColor?.withOpacity(0.9) ?? Palette.mainAppColorBack,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: (iconBackColor ?? Palette.mainAppColorBack).withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    icon,
                    color: Palette.mainAppColorWhite,
                    size: 18,
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Title
                Expanded(
                  child: Text(
                    title,
                    style: AppStyles.textCairo(
                      14,
                      Palette.mainAppColorWhite,
                      FontWeight.w500,
                    ),
                  ),
                ),
                
                // Trailing Icon with animation
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    trailingIcon ?? Icons.arrow_forward_ios,
                    color: Palette.gray.withOpacity(0.8),
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
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
      Get.toNamed(Routes.selectEnter);
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
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Image.asset(Assets.notFound),
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
    );
  }
}
