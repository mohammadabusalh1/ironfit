import 'package:flutter/material.dart';
import 'package:ironfit/features/userEnteInfo/widgets/user_enter_info_body.dart';
class UserEnterInfoScreen extends StatelessWidget {
  final String userId; // Accept coach ID here

  UserEnterInfoScreen({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UserEnterInfoBody(
        userId: this.userId,
      ),
    );
  }
}
