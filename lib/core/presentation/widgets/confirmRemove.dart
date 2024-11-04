import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';

Future<bool> confirmCancel(context) async {
  bool confirmCancel = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Palette.secondaryColor,
        alignment: Alignment.center,
        title: Text(
          LocalizationService.translateFromGeneral('cancelConfirmation'),
          textAlign: TextAlign.end,
          style: AppStyles.textCairo(18, Palette.mainAppColorWhite, FontWeight.w500),
        ),
        content: Text(
          LocalizationService.translateFromGeneral('deletePlanConfirmation'),
          textAlign: TextAlign.end,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // User canceled
            },
            child: Text(LocalizationService.translateFromGeneral('cancel'),
                style: AppStyles.textCairo(12, Palette.mainAppColorWhite, FontWeight.w500)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Palette.redDelete,
            ),
            onPressed: () {
              Navigator.of(context).pop(true); // User confirmed
            },
            child: Text(LocalizationService.translateFromGeneral('confirm'),
                style: AppStyles.textCairo(14, Palette.white, FontWeight.w500)),
          ),
        ],
      );
    },
  );
  return confirmCancel;
}
