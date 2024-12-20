import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ironfit/core/presentation/controllers/sharedPreferences.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/Button.dart';
import 'package:ironfit/core/presentation/widgets/CheckTockens.dart';
import 'package:ironfit/core/presentation/widgets/ForgotPasswordDialog.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';
import 'package:ironfit/core/presentation/widgets/customSnackbar.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:ironfit/features/regestraion/login/widgets/buildHeaderImages.dart';
import 'package:ironfit/features/regestraion/login/widgets/buildWelcomeText.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool passwordVisibility = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  PreferencesService preferencesService = PreferencesService();
  TokenService tokenService = TokenService();
  CustomSnackbar customSnackbar = CustomSnackbar();

  late String dir;
  late bool type = false;

  @override
  void initState() {
    super.initState();
    tokenService.checkTokenAndNavigateDashboard();
    checkType();
    dir = LocalizationService.getDir();
  }

  Future<void> checkType() async {
    SharedPreferences prefs = await preferencesService.getPreferences();
    setState(() {
      type = prefs.getBool('isCoach') ?? false;
    });
  }

  Future<void> signInWithGoogle() async {
    try {
      Get.dialog(const Center(child: CircularProgressIndicator()),
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
      DocumentSnapshot coacheDoc =
          await coachesCollection.doc(userCredential.user!.uid).get();

      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('trainees');
      DocumentSnapshot userDoc =
          await usersCollection.doc(userCredential.user!.uid).get();

      if (coacheDoc.exists) {
        SharedPreferences prefs = await preferencesService.getPreferences();
        prefs.setString('token', userCredential.user!.uid);
        Get.toNamed(Routes.coachDashboard)?.then(
          (value) {
            Navigator.pop(context);
          },
        );
      } else if (userDoc.exists) {
        SharedPreferences prefs = await preferencesService.getPreferences();
        prefs.setString('token', userCredential.user!.uid);
        Get.toNamed(Routes.trainerDashboard)?.then(
          (value) {
            Navigator.pop(context);
          },
        );
      } else if (userCredential.user != null) {
        SharedPreferences prefs = await preferencesService.getPreferences();
        prefs.setString('token', userCredential.user!.uid);
        bool isCoach = prefs.getBool('isCoach') ?? false;
        if (isCoach) {
          Get.toNamed(Routes.coachEnterInfo)?.then(
            (value) {
              Navigator.pop(context);
            },
          );
        } else {
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

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        Get.dialog(const Center(child: CircularProgressIndicator()),
            barrierDismissible: false);

        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passwordController.text);

        User? user = userCredential.user;
        if (user == null) throw Exception('No user found');

        SharedPreferences prefs = await preferencesService.getPreferences();
        bool isCoach = prefs.getBool('isCoach') ?? false;
        String collectionPath = isCoach ? 'coaches' : 'trainees';

        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection(collectionPath)
            .doc(user.uid)
            .get();

        if (userSnapshot.exists) {
          prefs.setString('token', userSnapshot.id);
          if (isCoach) {
            prefs.setString('coachId', user.uid);
            Get.toNamed(Routes.coachDashboard);
          } else {
            Get.toNamed(Routes.trainerDashboard);
          }
        } else {
          throw Exception(
              LocalizationService.translateFromGeneral('checkInfo'));
        }
      } catch (e) {
        Get.back();
        customSnackbar.showMessage(
            context, LocalizationService.translateFromGeneral('checkInfo'));
      }
    }
  }

  Widget _buildTypeSelectionButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          width: double.infinity,
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: type ? Palette.mainAppColorOrange : Palette.mainAppColorWhite,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () async {
              SharedPreferences prefs = await preferencesService.getPreferences();
              setState(() {
                type = !type;
                prefs.setBool('isCoach', type);
              });
            },
            child: Text(
              type 
                ? LocalizationService.translateFromGeneral('iAmTrainee')
                : LocalizationService.translateFromGeneral('iAmCoach'),
              style: AppStyles.textCairo(
                14,
                type ? Palette.mainAppColorWhite : Palette.mainAppColorNavy,
                FontWeight.w700
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.12),
                  AnimatedScreen(),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        WelcomeText(),
                        const SizedBox(height: 24),
                        _buildTypeSelectionButton(),
                        const SizedBox(height: 24),
                        _buildEmailTextField(context),
                        const SizedBox(height: 12),
                        _buildPasswordTextField(context),
                        const SizedBox(height: 24),
                        BuildIconButton(
                          height: 50,
                          text:
                              LocalizationService.translateFromGeneral('login'),
                          onPressed: () {
                            _login();
                          },
                          backgroundColor: Palette.mainAppColor,
                          textColor: Palette.white,
                          width: MediaQuery.of(context).size.width,
                        ),
                        const SizedBox(height: 8),
                        BuildIconButton(
                          height: 50,
                          text: LocalizationService.translateFromGeneral(
                              'sign_in_with_google'),
                          onPressed: () async {
                            try {
                              await signInWithGoogle();
                            } catch (e) {
                              customSnackbar.showFailureMessage(context);
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
                          width: MediaQuery.of(context).size.width,
                        ),
                        TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ForgotPasswordDialog();
                              },
                            );
                          },
                          child: Text(
                            LocalizationService.translateFromGeneral(
                                'areYouForgetPassword'),
                            style: AppStyles.textCairo(
                                14, Palette.mainAppColorWhite, FontWeight.w500),
                          ),
                        ),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, Routes.singUp);
                            },
                            child: Text(
                              LocalizationService.translateFromGeneral(
                                  'create_account'),
                              style: AppStyles.textCairo(
                                  14, Palette.mainAppColor, FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailTextField(BuildContext context) {
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(
        labelText: LocalizationService.translateFromGeneral('email'),
        hintText: 'abc@gmail.com',
        hintStyle: AppStyles.textCairo(14, Palette.gray, FontWeight.w500),
        labelStyle: AppStyles.textCairo(14, Palette.gray, FontWeight.w500),
        filled: true,
        fillColor: Palette.secondaryColor,
        enabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: Palette.mainAppColorBorder, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: const Padding(
          padding: EdgeInsets.all(10.0), // Adjust padding if needed
          child: Icon(
            Icons.email_outlined,
            color: Palette.gray,
            size: 20,
          ),
        ),
        errorStyle: TextStyle(fontSize: 12.0),
      ),
      style:
          AppStyles.textCairo(14, Palette.mainAppColorWhite, FontWeight.w500),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return LocalizationService.translateFromGeneral('thisFieldRequired');
        }
        if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
          return LocalizationService.translateFromGeneral('invalidEmail');
        }
        return null;
      },
    );
  }

  Widget _buildPasswordTextField(BuildContext context) {
    return TextFormField(
      controller: passwordController,
      obscureText: !passwordVisibility,
      decoration: InputDecoration(
        errorStyle: TextStyle(fontSize: 12.0),
        labelText: LocalizationService.translateFromGeneral('password'),
        hintText: '**',
        hintStyle: AppStyles.textCairo(14, Palette.gray, FontWeight.w500),
        labelStyle: AppStyles.textCairo(14, Palette.gray, FontWeight.w500),
        filled: true,
        fillColor: Palette.secondaryColor,
        enabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: Palette.mainAppColorBorder, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: InkWell(
          onTap: () => setState(() {
            passwordVisibility = !passwordVisibility;
          }),
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
      style: AppStyles.textCairo(14, Palette.white, FontWeight.w500),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return LocalizationService.translateFromGeneral('thisFieldRequired');
        }
        if (value.length < 6) {
          return LocalizationService.translateFromGeneral('newPasswordError2');
        }
        return null;
      },
    );
  }
}
