import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/widgets/app_bar.dart';
import 'package:ironfit/features/regestraion/register/widgets/sign_up_body.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SignUpBody(),
    );
  }
}
