import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presention/style/assets.dart';
import 'package:ironfit/core/presention/style/palette.dart';
import 'package:ironfit/core/routes/routes.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
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
                  // _buildPrivacyText(context),
                  // const SizedBox(height: 12),
                  _buildLoginButton(),
                  const SizedBox(height: 12),
                  _buildGoogleRegisterButton(),
                  const SizedBox(height: 24),
                  _buildLoginText(context),
                ],
              )),
        ],
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
    return Container(
      child: TextFormField(
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
      ),
    );
  }

  Widget _buildPasswordTextField(BuildContext context) {
    return SizedBox(
      child: StatefulBuilder(
        builder: (context, setState) {
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
                borderSide:
                    const BorderSide(color: Color(0xFFFFBB02), width: 1),
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
          );
        },
      ),
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
          constraints: const BoxConstraints(
            minHeight: 45,
          ),
          child: ElevatedButton(
            onPressed: () {
              if (isCoach) {
                Get.toNamed(Routes.home);
              } else {
                Get.toNamed(Routes.trainerDashboard);
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
            child: const Text('تسجيل الدخول'),
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
            minHeight: 45,
          ),
          child: ElevatedButton.icon(
            onPressed: () {
              // Handle button press
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color(0xFF1C1503),
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            label: const Text('التسجيل عبر Google',
                style: TextStyle(fontSize: 14)),
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
