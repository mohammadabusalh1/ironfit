import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/features/coachEnteInfo/screens/coach_ente_info_screen.dart';
import 'package:ironfit/features/regestraion/login/widgets/buildHeaderImages.dart';
import 'package:ironfit/features/regestraion/login/widgets/buildWelcomeText.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ironfit/features/userEnteInfo/screens/user_ente_info_screen.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({super.key});

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Form Key for Validation

  bool passwordVisibility = false;
  bool isCoach = false;

  // Firebase Auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to save coach data
  Future<String> saveCoachData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      CollectionReference users = FirebaseFirestore.instance.collection('coaches');
      await users.doc(user.uid).set({
        'email': user.email,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return user.uid;
    } else {
      return '';
    }
  }

  // Method to save trainee data
  Future<String> saveTraineeData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      CollectionReference users = FirebaseFirestore.instance.collection('trainees');
      await users.doc(user.uid).set({
        'email': user.email,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return user.uid;
    } else {
      return '';
    }
  }

  // Method to register a new user using email and password
  Future<void> _registerUser() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        // Save data based on the user type (coach/trainee)
        if (isCoach) {
          String userId = await saveCoachData();
          if (userId.isEmpty) {
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Directionality(
                textDirection: TextDirection.rtl,
                child: CoachEnterInfoScreen(coachId: userId),
              ),
            ),
          );
        } else {
          await saveTraineeData();
          Get.to(Directionality(
              textDirection: TextDirection.rtl,
              child: UserEnterInfoScreen(
                userId: userCredential.user!.uid,
              )));
        }
      } catch (e) {
        // Handle errors
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
              'المستخدم موجود مسبقاً',
              style: const TextStyle(color: Colors.white),
              textDirection: TextDirection.rtl,
            ));
      }
    }
  }

  // Input Validation Method
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    }
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password should be at least 6 characters';
    }
    return null;
  }

  // Google sign-in method
  Future<User?> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      Get.snackbar('Error', 'Google Sign-In failed');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: _formKey,
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
                  _buildRegisterButton(),
                  const SizedBox(height: 12),
                  _buildGoogleRegisterButton(),
                  const SizedBox(height: 24),
                  _buildLoginText(context),
                ],
              ),
            ),
          ],
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
      validator: _validateEmail,
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
          onTap: () {
            setState(() {
              passwordVisibility = !passwordVisibility;
            });
          },
          child: Icon(
            passwordVisibility ? Icons.visibility_outlined : Icons.visibility_off_outlined,
            size: 20,
            color: Palette.white,
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
        ),
      ],
    );
  }

  Widget _buildRegisterButton() {
    return SizedBox(
      child: Align(
        alignment: const AlignmentDirectional(0, 1),
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(
            minHeight: 45,
          ),
          child: ElevatedButton(
            onPressed: _registerUser,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              backgroundColor: const Color(0xFFFFBB02),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'تسجيل',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleRegisterButton() {
    return Container(
      height: 45,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: _signInWithGoogle,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.googleLogo,
              height: 25,
              width: 25,
            ),
            const SizedBox(width: 8),
            const Text(
              'Sign up with Google',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account?',
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Login',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
