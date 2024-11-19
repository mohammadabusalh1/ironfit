import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
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

  void showMessageAbove(context, String message) {
    Get.snackbar('', message,
        backgroundColor: Palette.secondaryColor,
        colorText: Palette.mainAppColorWhite,
        messageText: Text(
          message,
          textAlign: TextAlign.center,
        ));
  }

  void showFailureMessage(context) {
    Get.snackbar(
        '', LocalizationService.translateFromPage('message', failurePageName),
        backgroundColor: Palette.secondaryColor,
        colorText: Palette.mainAppColorWhite,
        messageText: Text(
          LocalizationService.translateFromPage('message', failurePageName),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Palette.mainAppColorWhite,
          ),
        ));
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
