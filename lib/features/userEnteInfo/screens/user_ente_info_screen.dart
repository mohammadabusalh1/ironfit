import 'package:flutter/material.dart';
import 'package:ironfit/features/userEnteInfo/widgets/user_enter_info_body.dart';

class UserEnterInfoScreen extends StatelessWidget {
  UserEnterInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UserEnterInfoBody(),
    );
  }
}
