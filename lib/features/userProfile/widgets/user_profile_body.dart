import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/controllers/sharedPreferences.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/hederImage.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? fullName;
String trainerImage =
    'https://cdn.vectorstock.com/i/500p/30/21/data-search-not-found-concept-vector-36073021.jpg';
bool isDataLoaded = false;

class UserProfileBody extends StatefulWidget {
  const UserProfileBody({Key? key}) : super(key: key);

  @override
  _UserProfileBodyState createState() => _UserProfileBodyState();
}

class _UserProfileBodyState extends State<UserProfileBody> {
  bool isLoading = true;
  PreferencesService preferencesService = PreferencesService();
  String numberOfDays = '0';
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
    fetchUserDays();
    if (!isDataLoaded) {
      fetchUserName();
      setState(() {
        isDataLoaded = true;
      });
    }
  }

  Future<void> fetchUserDays() async {
    String? userId = _auth.currentUser?.uid;

    try {
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

      // Check if 'coachId' and 'subscriptionId' fields exist before accessing them
      String? coachId = userData?['coachId'];
      String? subscriptionId = userData?['subscriptionId'];

      if (coachId != null && subscriptionId != null) {
        DocumentSnapshot subscriptionDoc = await FirebaseFirestore.instance
            .collection('coaches')
            .doc(coachId)
            .collection('subscriptions')
            .doc(subscriptionId)
            .get();

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
      } else {
        setState(() {
          numberOfDays = '0';
        });
      }
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
    final _formKey = GlobalKey<FormState>(); // Form validation key
    final TextEditingController firstNameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();
    final TextEditingController ageController = TextEditingController();
    final TextEditingController wightController = TextEditingController();
    final TextEditingController heightController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogBackgroundColor: Colors.grey[900],
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Palette.white, fontSize: 16),
              bodyMedium: TextStyle(color: Palette.white, fontSize: 14),
              headlineLarge: TextStyle(
                  color: Palette.white,
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
              labelStyle: TextStyle(color: Palette.white, fontSize: 14),
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
              hintStyle: TextStyle(color: Palette.gray, fontSize: 14),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Palette.white,
              ),
            ),
          ),
          child: Expanded(
            child: SingleChildScrollView(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: AlertDialog(
                  title: Text(
                    LocalizationService.translateFromGeneral('editInfo'),
                    style: const TextStyle(
                        color: Palette.white,
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
                          decoration: InputDecoration(
                              prefixIcon: const Padding(
                                padding: EdgeInsets.all(
                                    10.0), // Adjust padding if needed
                                child: Icon(
                                  Icons.person_outline,
                                  color: Palette.gray,
                                  size: 20,
                                ),
                              ),
                              label: Text(
                                  LocalizationService.translateFromGeneral(
                                      'firstNameLabel'),
                                  style: const TextStyle(color: Colors.grey))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return LocalizationService.translateFromGeneral(
                                  'firstNameError');
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: lastNameController,
                          decoration: InputDecoration(
                              prefixIcon: const Padding(
                                padding: EdgeInsets.all(
                                    10.0), // Adjust padding if needed
                                child: Icon(
                                  Icons.person_outline,
                                  color: Palette.gray,
                                  size: 20,
                                ),
                              ),
                              label: Text(
                                  LocalizationService.translateFromGeneral(
                                      'lastNameLabel'),
                                  style: const TextStyle(color: Colors.grey))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return LocalizationService.translateFromGeneral(
                                  'lastNameError ');
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: ageController,
                          decoration: InputDecoration(
                              prefixIcon: const Padding(
                                padding: EdgeInsets.all(
                                    10.0), // Adjust padding if needed
                                child: Icon(
                                  Icons.group_outlined,
                                  color: Palette.gray,
                                  size: 20,
                                ),
                              ),
                              label: Text(
                                  LocalizationService.translateFromGeneral(
                                      'age'),
                                  style: const TextStyle(color: Colors.grey))),
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
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: wightController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              prefixIcon: const Padding(
                                padding: EdgeInsets.all(
                                    10.0), // Adjust padding if needed
                                child: Icon(
                                  Icons.scale_outlined,
                                  color: Palette.gray,
                                  size: 20,
                                ),
                              ),
                              label: Text(
                                  LocalizationService.translateFromGeneral(
                                      'wight'),
                                  style: const TextStyle(color: Colors.grey))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return LocalizationService.translateFromGeneral(
                                  'wightError');
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: heightController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              prefixIcon: const Padding(
                                padding: EdgeInsets.all(
                                    10.0), // Adjust padding if needed
                                child: Icon(
                                  Icons.height_outlined,
                                  color: Palette.gray,
                                  size: 20,
                                ),
                              ),
                              label: Text(
                                  LocalizationService.translateFromGeneral(
                                      'height'),
                                  style: const TextStyle(color: Colors.grey))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return LocalizationService.translateFromGeneral(
                                  'heightError');
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
                          final FirebaseAuth _auth = FirebaseAuth.instance;
                          String? userId = _auth.currentUser?.uid;
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
              bodyLarge: TextStyle(color: Palette.white, fontSize: 16),
              bodyMedium: TextStyle(color: Palette.white, fontSize: 14),
              headlineLarge: TextStyle(
                  color: Palette.white,
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
              fillColor: Palette.secondaryColor, // Adjust color
              labelStyle: TextStyle(color: Palette.white, fontSize: 14),
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
              style: TextButton.styleFrom(foregroundColor: Palette.white),
            ),
          ),
          child: Expanded(
            child: SingleChildScrollView(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: AlertDialog(
                  title: Text(
                    LocalizationService.translateFromGeneral('changePassword'),
                    style: const TextStyle(
                        color: Palette.white,
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
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: oldPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: const Padding(
                              padding: EdgeInsets.all(
                                  10.0), // Adjust padding if needed
                              child: Icon(
                                Icons.lock_outline,
                                color: Palette.gray,
                                size: 20,
                              ),
                            ),
                            label: Text(
                                LocalizationService.translateFromGeneral(
                                    'oldPassword'),
                                style: const TextStyle(color: Colors.grey)),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجى إدخال كلمة المرور القديمة';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: newPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: const Padding(
                              padding: EdgeInsets.all(
                                  10.0), // Adjust padding if needed
                              child: Icon(
                                Icons.lock_outline,
                                color: Palette.gray,
                                size: 20,
                              ),
                            ),
                            label: Text(
                                LocalizationService.translateFromGeneral(
                                    'newPassword'),
                                style: const TextStyle(color: Colors.grey)),
                          ),
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
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: const Padding(
                              padding: EdgeInsets.all(
                                  10.0), // Adjust padding if needed
                              child: Icon(
                                Icons.lock_outline,
                                color: Palette.gray,
                                size: 20,
                              ),
                            ),
                            label: Text(
                                LocalizationService.translateFromGeneral(
                                    'confirmPassword'),
                                style: TextStyle(color: Colors.grey)),
                          ),
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
                trainerImage,
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
            style: const TextStyle(
              color: Palette.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "${LocalizationService.translateFromGeneral('daysRemaining')} $numberOfDays ${LocalizationService.translateFromGeneral('days')}",
                style: const TextStyle(
                  color: Palette.subTitleGrey,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 0.8,
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
              style: const TextStyle(
                fontFamily: 'Inter',
                color: Palette.white,
                letterSpacing: 0.0,
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
      prefs.clear();
      Get.toNamed(Routes.singIn);
    } catch (e) {
      Get.snackbar('خطأ', 'فشل تسجيل الخروج.',
          titleText: const Text(
            'خطأ',
            textAlign: TextAlign.right,
          ),
          messageText: const Text(
            'فشل تسجيل الخروج.',
            textAlign: TextAlign.right,
          ));
    }
  }
}
