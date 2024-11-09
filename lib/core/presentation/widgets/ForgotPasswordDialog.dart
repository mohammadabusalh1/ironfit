import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ironfit/core/presentation/widgets/customSnackbar.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';
import 'package:ironfit/core/presentation/widgets/theme.dart'; // Assuming Firebase Auth is used for authentication

class ForgotPasswordDialog extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  CustomSnackbar customSnackbar = CustomSnackbar();
  final dir = LocalizationService.getDir();

  void resetPassword(BuildContext context) async {
    String email = emailController.text.trim();
    if (email.isNotEmpty) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        Navigator.pop(context); // Close the dialog after sending reset email
        // Show success message or navigate to a success screen
        customSnackbar.showMessageAbove(context,
            LocalizationService.translateFromGeneral('resetEmailSentMessage'));
      } catch (e) {
        // Handle errors (e.g., user not found, email format invalid)
        customSnackbar.showMessageAbove(
            context,
            LocalizationService.translateFromGeneral(
                'resetEmailFailedMessage'));
      }
    } else {
      customSnackbar.showMessageAbove(context,
          LocalizationService.translateFromGeneral('thisFieldRequired'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: customThemeData,
        child: Directionality(
          textDirection: dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
          child: AlertDialog(
            title: Text(LocalizationService.translateFromGeneral(
                'forgotPasswordMessage')),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText:
                          LocalizationService.translateFromGeneral('email'),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(LocalizationService.translateFromGeneral('cancel')),
              ),
              ElevatedButton(
                onPressed: () => resetPassword(context),
                child: Text(LocalizationService.translateFromGeneral('reset')),
              ),
            ],
          ),
        ));
  }
}
