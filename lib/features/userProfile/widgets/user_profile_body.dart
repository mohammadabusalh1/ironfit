import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/controllers/sharedPreferences.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/CheckTockens.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';
import 'package:ironfit/core/presentation/widgets/customSnackbar.dart';
import 'package:ironfit/core/presentation/widgets/hederImage.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';
import 'package:ironfit/core/presentation/widgets/theme.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:ironfit/features/editPlan/widgets/BuildTextField.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? fullName;
String trainerImage =
    'https://cdn.vectorstock.com/i/500p/30/21/data-search-not-found-concept-vector-36073021.jpg';
bool isDataLoaded = false;

class UserProfileBody extends StatefulWidget {
  const UserProfileBody({super.key});

  @override
  _UserProfileBodyState createState() => _UserProfileBodyState();
}

class _UserProfileBodyState extends State<UserProfileBody> {
  bool isLoading = true;
  PreferencesService preferencesService = PreferencesService();
  String numberOfDays = '0';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TokenService tokenService = TokenService();
  CustomSnackbar customSnackbar = CustomSnackbar();
  late String dir;

  @override
  void initState() {
    super.initState();
    tokenService.checkTokenAndNavigateSingIn();
    fetchUserDays();
    if (!isDataLoaded) {
      fetchUserName();
      setState(() {
        isDataLoaded = true;
      });
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

      Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;

      var subscription= await FirebaseFirestore.instance
          .collection('subscriptions')
          .where('userId', isEqualTo: userId)
          .get();

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
      String? lastName = userData?['lastName'];
      String profileImageUrl = userData?['profileImageUrl'] ?? Assets.notFound;

      setState(() {
        fullName = '$firstName $lastName';
        trainerImage = profileImageUrl;
      });
    } catch (e) {
      // Handle specific exceptions if needed, e.g., FirebaseException
      print("Error fetching user data: $e");
      // You can also show a user-friendly message on the UI
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
    return Scaffold(
        body: Column(
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
                        _buildButtonCard(
                            context,
                            LocalizationService.translateFromGeneral(
                                'personalInformation'),
                            Icons.person, () {
                          showEditInfoDialog(context);
                        }),
                        const SizedBox(height: 4),
                        _buildButtonCard(
                            context,
                            LocalizationService.translateFromGeneral(
                                'changePassword'),
                            Icons.vpn_key, () {
                          showEditPasswordDialog(context);
                        }),
                        const SizedBox(height: 4),
                        _buildButtonCard(
                            context,
                            LocalizationService.translateFromGeneral('logout'),
                            Icons.login_outlined, () {
                          _logout();
                        }),
                        const SizedBox(height: 12),
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50), // Match the borderRadius
              child: Image.network(
                trainerImage.isEmpty ? Assets.notFound : trainerImage,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
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
              FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "${LocalizationService.translateFromGeneral('daysRemaining')} $numberOfDays ${LocalizationService.translateFromGeneral('days')}",
                style: AppStyles.textCairo(
                  14,
                  Palette.subTitleGrey,
                  FontWeight.w300,
                ),
                textAlign: TextAlign.center,
              )),
        ],
      ),
    );
  }

  Widget _buildButtonCard(
      BuildContext context, String tilte, IconData icon, VoidCallback onClick) {
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
            const Icon(
              Icons.arrow_forward_ios_outlined,
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
      prefs.remove('userId');
      prefs.remove('token');
      prefs.remove('isCoach');
      Get.toNamed(Routes.selectEnter);
    } catch (e) {
      customSnackbar.showFailureMessage(context);
    }
  }
}
