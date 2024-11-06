import 'package:flutter/material.dart';
import 'package:ironfit/features/userEnteInfo/widgets/user_enter_info_body.dart';

class UserEnterInfoScreen extends StatelessWidget {
  Function registerUser;
  UserEnterInfoScreen({super.key, required this.registerUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UserEnterInfoBody(
        registerUser: registerUser,
      ),
    );
  }
}
