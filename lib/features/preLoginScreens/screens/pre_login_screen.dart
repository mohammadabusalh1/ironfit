import 'package:flutter/material.dart';
import 'package:ironfit/features/preLoginScreens/widgets/pre_login_body.dart';

class PreLoginScreen extends StatelessWidget {
  const PreLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PreLoginBody(),
    );
  }
}
