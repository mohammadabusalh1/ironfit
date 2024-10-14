import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/routes/routes.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
          key: _formKey, // Add this
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                _buildHeaderImages(),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      _buildWelcomeText(context),
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
                      _buildLoginText(context),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget _buildHeaderImages() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            Assets.singUpImage,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.3,
            fit: BoxFit.cover,
          ),
        ),
        Center(
          // Wrap the logo in Center
          child: ClipRRect(
            child: Image.asset(
              Assets.ironFitLogo,
              width: MediaQuery.of(context).size.height * 0.3,
              height: MediaQuery.of(context).size.height * 0.3,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeText(BuildContext context) {
    return const Text(
      'مرحباً بك، يرجى إدخال بياناتك',
      style: TextStyle(
        fontFamily: 'Inter',
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildEmailTextField(BuildContext context) {
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(
        labelText: 'الإيميل',
        hintText: 'abc@gmail.com',
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        labelStyle: const TextStyle(color: Colors.white, fontSize: 14),
        filled: true,
        fillColor: const Color(0xFF454038),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFFFBB02), width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
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
          return 'الأيميل غير صالح';
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
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        labelStyle: const TextStyle(color: Colors.white, fontSize: 14),
        filled: true,
        fillColor: const Color(0xFF454038),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFFFBB02), width: 1),
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
            size: 20,
            color: Palette.white,
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
          inactiveTrackColor: Colors.grey,
        ),
      ],
    );
  }

  Widget _buildPrivacyText(BuildContext context) {
    return const Opacity(
      opacity: 0.7,
      child: Text(
        'بتسجيلك أنت موافق على سياسة الخصوصية وشروط الإستخدام',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 14, height: 1.5),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      child: Align(
        alignment: const AlignmentDirectional(0, 1),
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 45),
          child: ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                try {
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
                            await SharedPreferences.getInstance();
                        prefs.setString('coachId', user.uid);
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
                        // Navigate to trainee dashboard
                        Get.toNamed(Routes.trainerDashboard);
                      } else {
                        throw Exception('المستخدم غير موجود');
                      }
                    }
                  }
                } catch (e) {
                  print(e.toString());
                  // Handle sign-in error
                  Get.snackbar('خطأ', 'يتعذر تسجيل الدخول',
                      snackPosition: SnackPosition.BOTTOM,
                      colorText: Palette.white,
                      margin: EdgeInsets.all(10),
                      titleText: const Text(
                        textDirection: TextDirection.rtl,
                        'يتعذر تسجيل الدخول',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      messageText: Text(
                        'الأيميل او كلمة المرور غير صحيحة',
                        style: const TextStyle(color: Colors.white),
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
                fontWeight: FontWeight.bold,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('تسجيل الدخول',
                style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } else {
      throw Exception("Google sign-in failed");
    }
  }

  Widget _buildGoogleRegisterButton() {
    return SizedBox(
      child: Align(
        alignment: const AlignmentDirectional(0, 1),
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(
            minHeight: 45,
          ),
          child: ElevatedButton(
            onPressed: () async {
              try {
                await signInWithGoogle();
                Get.snackbar('Success', 'Google Sign-In Successful',
                    backgroundColor: Colors.green, colorText: Colors.white);
              } catch (e) {
                print(e.toString());
                Get.snackbar('Error', e.toString(),
                    backgroundColor: Colors.red, colorText: Colors.white);
              }
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.googleLogo, // Add your Google logo image here
                  width: 20,
                  height: 20,
                ),
                const SizedBox(width: 10),
                const Text(
                  'التسجيل باستخدام جوجل',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'ليس لدي حساب! ',
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        const SizedBox(width: 4),
        InkWell(
          onTap: () => Get.toNamed(Routes.singUp),
          child: const Text(
            'إنشاء حساب',
            style: TextStyle(color: Color(0xFFFFBB02), fontSize: 14),
          ),
        ),
      ],
    );
  }
}
