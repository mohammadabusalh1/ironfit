import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ironfit/core/presentation/style/assets.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:ironfit/features/coachEnteInfo/screens/coach_ente_info_screen.dart';

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

  // Firebase Auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> saveCoachData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Get a reference to the Firestore "coaches" collection
      CollectionReference users =
          FirebaseFirestore.instance.collection('coaches');

      // Add the coach's data to Firestore
      await users.doc(user.uid).set({
        'email': user.email, // Store the coach's email
        'createdAt':
            FieldValue.serverTimestamp(), // Store account creation timestamp
      });

      // Return the coach's user ID after saving the data
      return user.uid;
    } else {
      // Return null if the user is not signed in
      return '';
    }
  }

  Future<String> saveTraineeData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Get a reference to the Firestore "trainees" collection
      CollectionReference users =
          FirebaseFirestore.instance.collection('trainees');

      // Add the user's data to Firestore
      await users.doc(user.uid).set({
        'email': user.email, // Store the user's email
        'createdAt':
            FieldValue.serverTimestamp(), // Store account creation timestamp
      });

      // Return the user's ID after saving the data
      return user.uid;
    } else {
      // Return null if the user is not signed in
      return '';
    }
  }

  // Method to register a new user using email and password
  Future<void> _registerUser() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        // Create user with email and password
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        // Now save user type to Firestore (use 'coach' or 'trainee' based on the switch)
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
          saveTraineeData();
          Get.toNamed(Routes.trainerDashboard);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: _formKey, // Attach the form key for validation
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
      validator: _validateEmail, // Attach validator
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
            passwordVisibility
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            size: 20,
            color: Palette.white,
          ),
        ),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 14),
      validator: _validatePassword, // Attach validator
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
            onPressed: _registerUser, // Call the register method
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color(0xFF1C1503),
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
      child: ElevatedButton(
        onPressed: () async {
          // Add Google Sign-In functionality here
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
    );
  }

  Widget _buildLoginText(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0, 1),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(Routes.singIn); // Navigate to sign-in screen
        },
        child: const Text(
          'تسجيل الدخول',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            color: Color(0xFFFFBB02),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
