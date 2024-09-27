import 'package:flutter/material.dart';
import 'package:ironfit/core/presention/style/assets.dart';

class SignUpBody extends StatefulWidget {

  const SignUpBody({super.key});

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool passwordVisibility = false;

  bool isCoach = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  _buildHeaderImages(),
                  const SizedBox(height: 24),
                  _buildWelcomeText(context),
                  const SizedBox(height: 24),
                  _buildEmailTextField(context),
                  const SizedBox(height: 12),
                  _buildPasswordTextField(context),
                  const SizedBox(height: 24),
                  _buildCoachSwitch(context),
                  const SizedBox(height: 24),
                  _buildPrivacyText(context),
                  const SizedBox(height: 12),
                  _buildRegisterButton(),
                  const SizedBox(height: 12),
                  _buildGoogleRegisterButton(),
                  const SizedBox(height: 10),
                  _buildLoginText(context),
                ],
              ),
            ),
          ),
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
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            Assets.ironFitLogo,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
            alignment: const Alignment(0, 0),
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
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildEmailTextField(BuildContext context) {
    return Opacity(
      opacity: 0.9,
      child: Container(
        child: TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: 'الإيميل',
            hintText: 'abc@gmail.com',
            labelStyle: const TextStyle(color: Colors.white, fontSize: 20),
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
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField(BuildContext context) {
    return Opacity(
      opacity: 0.9,
      child: SizedBox(
        child: StatefulBuilder(
          builder: (context, setState) {
            return TextFormField(
              controller: passwordController,
              obscureText: !passwordVisibility,
              decoration: InputDecoration(
                labelText: 'كلمة المرور',
                hintText: '**',
                labelStyle: const TextStyle(color: Colors.white, fontSize: 20),
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
                    size: 22,
                  ),
                ),
              ),
              style: const TextStyle(color: Colors.white, fontSize: 16),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCoachSwitch(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Switch.adaptive(
          value: isCoach,
          onChanged: (newValue) {
            isCoach = newValue;
          },
          activeColor: const Color(0xFFFFBB02),
          inactiveTrackColor: Colors.grey,
        ),
        const Text(
          'هل أنت مدرب؟',
          style: TextStyle(color: Colors.white, fontSize: 18),
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

  Widget _buildRegisterButton() {
    return SizedBox(
      height: 100,
      child: Align(
        alignment: const AlignmentDirectional(0, 1),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(
              minHeight: 50,
            ),
            child: ElevatedButton(
              onPressed: () {
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color(0xFF1C1503), padding: const EdgeInsets.symmetric(horizontal: 16), backgroundColor: const Color(0xFFFFBB02),
                textStyle: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('إنشاء حساب'),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleRegisterButton() {

    return SizedBox(
      child: Align(
        alignment: const AlignmentDirectional(0, 1),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(
              minHeight: 50,
            ),
            child:  ElevatedButton.icon(
              onPressed: () {
                // Handle button press
              },
              icon: const Icon(Icons.g_mobiledata, size: 16),
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color(0xFF1C1503), backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              label: const Text('Google التسجيل عبر', style: TextStyle(fontSize: 16)),
            ),
          ),
        ),
      ),
    );

  }

  Widget _buildLoginText(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          ' تسجيل الدخول',
          style: TextStyle(color: Color(0xFFFFBB02), fontSize: 16),
        ),
        SizedBox(width: 4),
        Text(
          '!لدي حساب بالفعل',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }
}
