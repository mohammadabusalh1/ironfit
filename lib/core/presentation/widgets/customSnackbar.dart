import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';

class CustomSnackbar {
  String failurePageName = 'snackbarFailure';
  String successPageName = 'snackbarSuccess';
  void showSuccessMessage(context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(LocalizationService.translateFromPage(
              'message', successPageName))),
    );
  }

  void showMessage(context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void showFailureMessage(context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(LocalizationService.translateFromPage(
              'message', failurePageName))),
    );
  }

  void showDoesNotExistMessage(context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(LocalizationService.translateFromPage(
              'doesNotExist', failurePageName))),
    );
  }

  void showInvalidFormatMessage(context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
              LocalizationService.translateFromGeneral('invalidFormatError'))),
    );
  }
}
