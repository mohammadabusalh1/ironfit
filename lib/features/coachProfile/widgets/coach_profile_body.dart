import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ironfit/core/presentation/controllers/sharedPreferences.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/hederImage.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:ironfit/features/coachProfile/controllers/coach_profile_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? fullName;
String imageUrl =
    'https://cdn.vectorstock.com/i/500p/30/21/data-search-not-found-concept-vector-36073021.jpg';
String email = '';
bool isDataLoaded = false;

class CoachProfileBody extends StatefulWidget {
  const CoachProfileBody({Key? key}) : super(key: key);

  @override
  _CoachProfileBodyState createState() => _CoachProfileBodyState();
}

class _CoachProfileBodyState extends State<CoachProfileBody> {
  final CoachProfileController controller = Get.find();
  bool isLoading = true;
  String coachId = FirebaseAuth.instance.currentUser!.uid;

  PreferencesService preferencesService = PreferencesService();
  Future<void> _checkToken() async {
    SharedPreferences prefs = await preferencesService.getPreferences();
    String? token = prefs.getString('token');

    if (token == null) {
      Get.toNamed(Routes.singIn); // Navigate to coach dashboard
    }
  }

  @override
  void initState() {
    super.initState();
    _checkToken();
    if (!isDataLoaded) {
      fetchUserName();
      setState(() {
        isDataLoaded = true;
      });
    }
  }

  Future<void> changeUserImage() async {
    final ImagePicker _picker = ImagePicker();

    // Pick an image from the gallery
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        isLoading = true;
      });

      try {
        try {
          Get.dialog(Center(child: CircularProgressIndicator()),
              barrierDismissible: false);
          final storageRef = FirebaseStorage.instance.ref().child(
              'profile_images/${FirebaseAuth.instance.currentUser!.uid}.jpg');
          await storageRef.putFile(File(pickedFile.path)).then(
            (snapshot) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(LocalizationService.translateFromGeneral(
                        'imageUploadSuccess'))),
              );
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

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(LocalizationService.translateFromGeneral(
                    'imageUploadSuccess'))),
          );

          Get.back();
        } catch (e) {
          Get.back();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(LocalizationService.translateFromGeneral(
                    'unexpectedError'))),
          );
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  '${LocalizationService.translateFromGeneral('unexpectedError')} $e')),
        );
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchUserName() async {
    // Get user data from Firestore
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection(
            'coaches') // or 'coaches', depending on where you store user data
        .doc(coachId)
        .get();

    if (userDoc.exists) {
      String? firstName = userDoc['firstName'];
      String? lastName = userDoc['lastName'];

      setState(() {
        fullName = '$firstName $lastName';
        email = userDoc['email'];
        imageUrl = userDoc['profileImageUrl'];
      });
    } else {
      print("User data not found");
      return null;
    }
  }

  void showEditInfoDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>(); // Form validation key
    final TextEditingController firstNameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();
    final TextEditingController ageController = TextEditingController();
    final TextEditingController experienceController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogBackgroundColor: Colors.grey[900],
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
              bodyMedium: TextStyle(color: Colors.white70, fontSize: 14),
              headlineLarge: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFBB02),
                foregroundColor: const Color(0xFF1C1503),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              filled: true,
              fillColor: Palette.secondaryColor,
              labelStyle: TextStyle(color: Colors.white, fontSize: 14),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow, width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2),
              ),
              hintStyle: TextStyle(color: Colors.white, fontSize: 14),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
            ),
          ),
          child: Expanded(
            child: SingleChildScrollView(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: AlertDialog(
                  title: const Text(
                    'تعديل المعلومات',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  content: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: firstNameController,
                          decoration:
                              const InputDecoration(hintText: 'الاسم الأول'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال الاسم الأول';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: lastNameController,
                          decoration:
                              const InputDecoration(hintText: 'الاسم الأخير'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال الاسم الأخير';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: ageController,
                          decoration: const InputDecoration(hintText: 'العمر'),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال العمر';
                            }
                            if (int.tryParse(value) == null) {
                              return 'يرجى إدخال قيمة صحيحة للعمر';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: experienceController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(hintText: 'الخبرة'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال الخبرة';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          try {
                            await FirebaseFirestore.instance
                                .collection('coaches')
                                .doc(coachId)
                                .update({
                              'firstName': firstNameController.text,
                              'lastName': lastNameController.text,
                              'age': ageController.text,
                              'experience': experienceController.text,
                            }).then((value) {
                              fetchUserName();
                            });
                            Navigator.of(context).pop();
                          } catch (e) {
                            // Handle errors (e.g., network issues, Firebase errors)
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    '${LocalizationService.translateFromGeneral('unexpectedError')} $e')));
                          }
                        }
                      },
                      child: const Text('حفظ'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: const Text('إلغاء'),
                    ),
                  ],
                  actionsAlignment: MainAxisAlignment.start,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void showEditPasswordDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController oldPasswordController = TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogBackgroundColor: Colors.grey[900],
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
              bodyMedium: TextStyle(color: Colors.white70, fontSize: 14),
              headlineLarge: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFBB02),
                foregroundColor: const Color(0xFF1C1503),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              filled: true,
              fillColor: Palette.secondaryColor,
              // Adjust color
              labelStyle: TextStyle(color: Colors.white, fontSize: 14),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow, width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2),
              ),
              hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: Colors.white),
            ),
          ),
          child: Expanded(
            child: SingleChildScrollView(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: AlertDialog(
                  title: Text(
                    LocalizationService.translateFromGeneral('changePassword'),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  content: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                            LocalizationService.translateFromGeneral(
                                'pleaseFillRequiredData'),
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: oldPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText:
                                  LocalizationService.translateFromGeneral(
                                      'oldPassword')),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return LocalizationService.translateFromGeneral(
                                  'oldPasswordError');
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: newPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText:
                                  LocalizationService.translateFromGeneral(
                                      'newPassword')),
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
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText:
                                  LocalizationService.translateFromGeneral(
                                      'confirmPassword')),
                          validator: (value) {
                            if (value != newPasswordController.text) {
                              return LocalizationService.translateFromGeneral(
                                  'passwordsDontMatch');
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
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
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette.black,
        body: Column(
          children: [
            Stack(
              children: [
                HeaderImage(),
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
        ));
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
                    ? CircularProgressIndicator() // Show loading indicator if image is empty
                    : Image.network(
                        imageUrl,
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
            style: const TextStyle(
              color: Palette.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            email, // If no name, display a default message
            style: const TextStyle(
              color: Palette.subTitleGrey,
              fontSize: 14,
              fontWeight: FontWeight.w100,
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
              color: Colors.white,
              size: 32,
            ),
            const SizedBox(width: 24), // Space between icon and text
            Text(
              tilte,
              style: const TextStyle(
                fontFamily: 'Inter',
                color: Colors.white,
                letterSpacing: 0.0,
              ),
            ),
            Spacer(), // Space between text and trailing icon
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
      Get.toNamed(Routes.singIn);
    } catch (e) {
      Get.snackbar(LocalizationService.translateFromGeneral('error'),
          LocalizationService.translateFromGeneral('logoutError'),
          titleText: Text(
            LocalizationService.translateFromGeneral('error'),
            textAlign: TextAlign.right,
          ),
          messageText: Text(
            LocalizationService.translateFromGeneral('logoutError'),
            textAlign: TextAlign.right,
          ));
    }
  }
}
