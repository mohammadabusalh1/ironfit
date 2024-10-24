import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ironfit/core/presentation/controllers/sharedPreferences.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
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
  bool isCoach = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  PreferencesService preferencesService = PreferencesService();

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

  Future<void> signInWithGoogle() async {
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
      DocumentSnapshot coacheDoc =
          await coachesCollection.doc(userCredential.user!.uid).get();

      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('trainees');
      DocumentSnapshot userDoc =
          await usersCollection.doc(userCredential.user!.uid).get();

      if (coacheDoc.exists) {
        SharedPreferences prefs = await preferencesService.getPreferences();
        prefs.setString('token', userCredential.user!.uid);
        prefs.setBool('isCoach', true);
        Get.toNamed(Routes.coachDashboard)?.then(
          (value) {
            Navigator.pop(context);
          },
        );
      } else if (userDoc.exists) {
        SharedPreferences prefs = await preferencesService.getPreferences();
        prefs.setString('token', userCredential.user!.uid);
        prefs.setBool('isCoach', false);
        Get.toNamed(Routes.trainerDashboard)?.then(
          (value) {
            Navigator.pop(context);
          },
        );
      } else if (userCredential.user != null) {
        SharedPreferences prefs = await preferencesService.getPreferences();
        prefs.setString('token', userCredential.user!.uid);
        if (isCoach) {
          prefs.setBool('isCoach', true);
          Get.toNamed(Routes.coachEnterInfo)?.then(
            (value) {
              Navigator.pop(context);
            },
          );
        } else {
          prefs.setBool('isCoach', false);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
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
                    _buildLoginButton(),
                    const SizedBox(height: 12),
                    _buildGoogleRegisterButton(),
                    const SizedBox(height: 24),
                    const LoginTextWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailTextField(BuildContext context) {
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(
        labelText: 'الإيميل',
        hintText: 'abc@gmail.com',
        hintStyle: const TextStyle(color: Palette.gray, fontSize: 14),
        labelStyle: const TextStyle(color: Palette.gray, fontSize: 14),
        filled: true,
        fillColor: const Color(0xFF454038),
        enabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: Palette.mainAppColorBorder, width: 1),
          borderRadius: BorderRadius.circular(10),
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'لا يمكنك ترك الحقل فارغ';
        }
        if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
          return 'الإيميل غير صالح';
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
        labelText: 'كلمة المرور',
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
      style: const TextStyle(color: Colors.white, fontSize: 14),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'لا يمكنك ترك الحقل فارغ';
        }
        if (value.length < 6) {
          return 'كلمة المرور قصيرة جداً';
        }
        return null;
      },
    );
  }

  Widget _buildCoachSwitch(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'هل أنت مدرب؟',
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        Switch.adaptive(
          value: isCoach,
          onChanged: (newValue) {
            setState(() {
              isCoach = newValue;
            });
          },
          activeColor: const Color(0xFFFFBB02),
          inactiveTrackColor: Palette.gray,
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      child: Align(
        alignment: const AlignmentDirectional(0, 1),
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 50),
          child: ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                try {
                  Get.dialog(Center(child: CircularProgressIndicator()),
                      barrierDismissible: false);

                  // Step 1: Sign in the user with FirebaseAuth
                  UserCredential userCredential = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text);

                  // Step 2: Get the current user from FirebaseAuth
                  User? user = userCredential.user;

                  // Step 5: Navigate based on userType
                  if (isCoach) {
                    // Step 3: Fetch user data from Firestore
                    if (user != null) {
                      DocumentSnapshot userSnapshot = await FirebaseFirestore
                          .instance
                          .collection('coaches')
                          .doc(user.uid)
                          .get();

                      if (userSnapshot.exists) {
                        SharedPreferences prefs =
                            await preferencesService.getPreferences();
                        prefs.setString('coachId', user.uid);
                        prefs.setString('token', userSnapshot.id);
                        prefs.setBool('isCoach', true);
                        // Navigate to coach dashboard
                        Get.toNamed(Routes.coachDashboard);
                      } else {
                        throw Exception('المستخدم غير موجود');
                      }
                    }
                  } else if (!isCoach) {
                    if (user != null) {
                      DocumentSnapshot userSnapshot = await FirebaseFirestore
                          .instance
                          .collection('trainees')
                          .doc(user.uid)
                          .get();

                      if (userSnapshot.exists) {
                        SharedPreferences prefs =
                            await preferencesService.getPreferences();
                        prefs.setString('token', userSnapshot.id);
                        prefs.setBool('isCoach', false);
                        Get.toNamed(Routes.trainerDashboard);
                      } else {
                        throw Exception('المستخدم غير موجود');
                      }
                    }
                  }
                } catch (e) {
                  // stop loading indicator
                  Get.back();

                  // Handle sign-in error
                  Get.snackbar('خطأ', 'يتعذر تسجيل الدخول',
                      snackPosition: SnackPosition.BOTTOM,
                      colorText: Palette.white,
                      margin: const EdgeInsets.all(10),
                      titleText: const Text(
                        textDirection: TextDirection.rtl,
                        'يتعذر تسجيل الدخول',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      messageText: const Text(
                        'الأيميل او كلمة المرور غير صحيحة',
                        style: TextStyle(color: Colors.white),
                        textDirection: TextDirection.rtl,
                      ));
                }
              }
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color(0xFF1C1503),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              backgroundColor: const Color(0xFFFFBB02),
              textStyle: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text('تسجيل الدخول',
                style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleRegisterButton() {
    return SizedBox(
      child: Align(
        alignment: const AlignmentDirectional(0, 1),
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(
            minHeight: 50,
          ),
          child: ElevatedButton.icon(
            icon: Image.asset(
              Assets.googleLogo,
              width: 24,
              height: 24,
            ),
            onPressed: () async {
              try {
                await signInWithGoogle();
              } catch (e) {
                Get.snackbar(
                  'فشل',
                  'يتعذر تسجيل الدخول باستخدام Google',
                  titleText: const Text(
                    'فشل',
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(color: Colors.white),
                  ),
                  messageText: const Text(
                    'يتعذر تسجيل الدخول باستخدام Google',
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(color: Colors.white),
                  ),
                  snackPosition: SnackPosition.BOTTOM,
                  colorText: Colors.white,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color(0xFF1C1503),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              backgroundColor: Colors.white,
              textStyle: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            label: const Text(
              'التسجيل باستخدام جوجل',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginTextWidget extends StatefulWidget {
  const LoginTextWidget({Key? key}) : super(key: key);

  @override
  _LoginTextWidgetState createState() => _LoginTextWidgetState();
}

class _LoginTextWidgetState extends State<LoginTextWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController and the Fade Animation
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = Tween(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    // Start the animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose(); // Clean up the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'ليس لدي حساب! ',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(width: 4),
          InkWell(
            onTap: () => Get.toNamed(Routes.singUp), // Use your desired route
            child: const Text(
              'إنشاء حساب',
              style: TextStyle(color: Color(0xFFFFBB02), fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
