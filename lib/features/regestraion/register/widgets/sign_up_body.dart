import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ironfit/core/presentation/controllers/sharedPreferences.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/Button.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:ironfit/features/regestraion/login/widgets/buildHeaderImages.dart';
import 'package:ironfit/features/regestraion/login/widgets/buildWelcomeText.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({super.key});

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // Form Key for Validation

  bool passwordVisibility = false;
  bool isCoach = false;
  PreferencesService preferencesService = PreferencesService();

  // Firebase Auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  Future<void> _checkToken() async {
    SharedPreferences prefs = await preferencesService.getPreferences();
    String? token = prefs.getString('token');

    if (token != null) {
      bool isCoach = prefs.getBool('isCoach') ?? false;
      // If the token exists, navigate to the respective dashboard
      if (isCoach) {
        Get.toNamed(Routes.coachDashboard); // Navigate to coach dashboard
      } else {
        Get.toNamed(Routes.trainerDashboard); // Navigate to trainer dashboard
      }
    }
  }

  // Method to save coach data
  Future<String> saveCoachData() async {
    try {
      // Check if user is authenticated
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Reference to the 'coaches' collection
        CollectionReference users =
            FirebaseFirestore.instance.collection('coaches');

        // Save coach data to Firestore
        await users.doc(user.uid).set({
          'email': user.email,
          'createdAt': FieldValue.serverTimestamp(),
        });

        return user.uid; // Return user ID if successful
      } else {
        throw FirebaseAuthException(
            code: 'user-not-found', message: 'No authenticated user found.');
      }
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase authentication errors
      print('FirebaseAuthException: ${e.message}');
      return 'Auth error: ${e.message}';
    } on FirebaseException catch (e) {
      // Handle Firebase-specific Firestore errors
      print('FirebaseException: ${e.message}');
      return 'Database error: ${e.message}';
    } catch (e) {
      // Handle any other errors
      print('General error: $e');
      return 'An unexpected error occurred: $e';
    }
  }

  // Method to save trainee data
  Future<String> saveTraineeData() async {
    try {
      // Check if the user is authenticated
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Reference to the 'trainees' collection
        CollectionReference users =
            FirebaseFirestore.instance.collection('trainees');

        // Save trainee data to Firestore
        await users.doc(user.uid).set({
          'email': user.email,
          'createdAt': FieldValue.serverTimestamp(),
        });

        return user.uid; // Return user ID if successful
      } else {
        throw FirebaseAuthException(
            code: 'user-not-found', message: 'No authenticated user found.');
      }
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase authentication errors
      print('FirebaseAuthException: ${e.message}');
      return 'Auth error: ${e.message}';
    } on FirebaseException catch (e) {
      // Handle Firebase Firestore-related errors
      print('FirebaseException: ${e.message}');
      return 'Database error: ${e.message}';
    } catch (e) {
      // Handle any other unexpected errors
      print('General error: $e');
      return 'An unexpected error occurred: $e';
    }
  }

  // Method to register a new user using email and password
  Future<void> _registerUser() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false);

        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        if (userCredential.user != null) {
          SharedPreferences prefs = await preferencesService.getPreferences();
          prefs.setString('token', userCredential.user!.uid);
          // Save data based on the user type (coach/trainee)
          if (isCoach) {
            prefs.setBool('isCoach', true);
            String userId = await saveCoachData();
            if (userId.isEmpty) {
              return;
            }
            Get.toNamed(Routes.coachEnterInfo);
          } else {
            prefs.setBool('isCoach', false);
            await saveTraineeData();
            Get.toNamed(Routes.userEnterInfo);
          }
        }
      } catch (e) {
        Navigator.pop(context);

        // Handle errors
        Get.snackbar(LocalizationService.translateFromGeneral('error'),
            LocalizationService.translateFromGeneral('accountCreationError'),
            snackPosition: SnackPosition.BOTTOM,
            colorText: Palette.white,
            margin: EdgeInsets.all(10),
            titleText: Text(
              textDirection: TextDirection.rtl,
              LocalizationService.translateFromGeneral('accountCreationError'),
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            messageText: Text(
              LocalizationService.translateFromGeneral('accountExist'),
              style: const TextStyle(color: Colors.white),
              textDirection: TextDirection.rtl,
            ));
      }
    }
  }

  Future<void> signUpWithGoogle() async {
    try {
      Get.dialog(Center(child: CircularProgressIndicator()),
          barrierDismissible: false);
      // Attempt to sign in with Google
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // User canceled the sign-in
        print('Sign-in aborted by user.');
        return;
      }

      // Get Google authentication credentials
      GoogleSignInAuthentication? googleAuth = await (await GoogleSignIn(
        scopes: ["profile", "email"],
      ).signIn())
          ?.authentication;

      // Create a new credential for Firebase Authentication
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Sign in to Firebase with the Google credentials
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      CollectionReference coachesCollection =
          FirebaseFirestore.instance.collection('coaches');
      QuerySnapshot<Object?> coacheDoc = await coachesCollection
          .where('email', isEqualTo: userCredential.user!.email)
          .get();

      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('trainees');
      QuerySnapshot<Object?> userDoc = await usersCollection
          .where('email', isEqualTo: userCredential.user!.email)
          .get();

      SharedPreferences prefs = await preferencesService.getPreferences();
      prefs.setString('token', userCredential.user!.uid);
      if (coacheDoc.docs.isNotEmpty) {
        prefs.setBool('isCoach', true);
        Get.toNamed(Routes.coachDashboard)?.then(
          (value) {
            Navigator.pop(context);
          },
        );
      } else if (userDoc.docs.isNotEmpty) {
        prefs.setBool('isCoach', false);
        Get.toNamed(Routes.trainerDashboard)?.then(
          (value) {
            Navigator.pop(context);
          },
        );
      } else if (userCredential.user != null) {
        if (isCoach) {
          prefs.setBool('isCoach', true);
          await saveCoachData();
          Get.toNamed(Routes.coachEnterInfo)?.then(
            (value) {
              Navigator.pop(context);
            },
          );
        } else {
          prefs.setBool('isCoach', false);
          await saveTraineeData();
          Get.toNamed(Routes.userEnterInfo)?.then(
            (value) {
              Navigator.pop(context);
            },
          );
        }
      } else {
        print('Sign-in failed: no user data returned.');
      }
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific errors
      print('FirebaseAuthException: ${e.message}');
    } on PlatformException catch (e) {
      print(e);
      // Handle platform-specific errors, like network issues
      print('PlatformException: ${e.message}');
    } catch (e) {
      // Handle general errors
      print('An unexpected error occurred: $e');
    }
  }

  // Input Validation Method
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'لا يمكنك ترك هذا الحقل فارغاً';
    }
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return 'البريد الإلكتروني غير صالح';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'لا يمكنك ترك هذا الحقل فارغاً';
    }
    if (value.length < 6) {
      return 'كلمة المرور قصيرة جداً';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                AnimatedScreen(),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      WelcomeText(),
                      const SizedBox(height: 24),
                      _buildEmailTextField(context),
                      const SizedBox(height: 12),
                      _buildPasswordTextField(context),
                      const SizedBox(height: 24),
                      _buildCoachSwitch(context),
                      const SizedBox(height: 24),
                      BuildIconButton(
                        text: LocalizationService.translateFromGeneral(
                            'create_account'),
                        onPressed: () {
                          _registerUser();
                        },
                        backgroundColor: Palette.mainAppColor,
                        textColor: Palette.white,
                      ),
                      const SizedBox(height: 8),
                      BuildIconButton(
                        text: LocalizationService.translateFromGeneral(
                            'sign_in_with_google'),
                        onPressed: () async {
                          try {
                            await signUpWithGoogle();
                          } catch (e) {
                            Get.snackbar(
                              LocalizationService.translateFromGeneral('error'),
                              LocalizationService.translateFromGeneral(
                                  'googleLoginFailure'),
                              titleText: Text(
                                LocalizationService.translateFromGeneral(
                                    'error'),
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(color: Colors.white),
                              ),
                              messageText: Text(
                                LocalizationService.translateFromGeneral(
                                    'googleLoginFailure'),
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(color: Colors.white),
                              ),
                              snackPosition: SnackPosition.BOTTOM,
                              colorText: Colors.white,
                            );
                          }
                        },
                        backgroundColor: Palette.mainAppColorWhite,
                        textColor: Palette.mainAppColorNavy,
                        icon: Icons.login,
                        imageIcon: Image.asset(
                          Assets.googleLogo,
                          width: 24,
                          height: 24,
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildLoginText(context),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget _buildEmailTextField(BuildContext context) {
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(
        labelText: LocalizationService.translateFromGeneral('email'),
        hintText: 'abc@gmail.com',
        hintStyle: const TextStyle(color: Palette.gray, fontSize: 14),
        labelStyle: const TextStyle(color: Palette.gray, fontSize: 14),
        filled: true,
        fillColor: const Color(0xFF454038),
        enabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: Palette.mainAppColorBorder, width: 1),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        prefixIcon: const Padding(
          padding: EdgeInsets.all(10.0), // Adjust padding if needed
          child: Icon(
            Icons.email_outlined,
            color: Palette.gray,
            size: 20,
          ),
        ),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 14),
      validator: _validateEmail,
    );
  }

  Widget _buildPasswordTextField(BuildContext context) {
    return TextFormField(
      controller: passwordController,
      obscureText: !passwordVisibility,
      decoration: InputDecoration(
        labelText: LocalizationService.translateFromGeneral('password'),
        hintText: '**',
        hintStyle: const TextStyle(color: Palette.gray, fontSize: 14),
        labelStyle: const TextStyle(color: Palette.gray, fontSize: 14),
        filled: true,
        fillColor: const Color(0xFF454038),
        enabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: Palette.mainAppColorBorder, width: 1),
          borderRadius: BorderRadius.circular(16),
        ),
        suffixIcon: InkWell(
          onTap: () {
            setState(() {
              passwordVisibility = !passwordVisibility;
            });
          },
          child: Icon(
            passwordVisibility
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            size: 18,
            color: Palette.white,
          ),
        ),
        prefixIcon: const Padding(
          padding: EdgeInsets.all(10.0), // Adjust padding if needed
          child: Icon(
            Icons.lock_outlined,
            color: Palette.gray,
            size: 20,
          ),
        ),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 14),
      validator: _validatePassword,
    );
  }

  Widget _buildCoachSwitch(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          LocalizationService.translateFromGeneral('are_you_a_trainer'),
          style: AppStyles.textCairo(
              16, Palette.mainAppColorWhite, FontWeight.normal),
        ),
        Switch.adaptive(
          value: isCoach,
          onChanged: (newValue) {
            setState(() {
              isCoach = newValue;
            });
          },
          activeColor: const Color(0xFFFFBB02),
        ),
      ],
    );
  }

  Widget _buildLoginText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          LocalizationService.translateFromGeneral('already_have_account'),
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        TextButton(
          onPressed: () {
            Get.toNamed(Routes.singIn);
          },
          child: Text(
            LocalizationService.translateFromGeneral('login'),
            style: TextStyle(color: Palette.mainAppColor, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
