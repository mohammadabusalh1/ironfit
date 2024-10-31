import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';

Future<bool> confirmCancel(context) async {
  bool confirmCancel = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        alignment: Alignment.center,
        title: Text(
          LocalizationService.translateFromGeneral('cancelConfirmation'),
          textAlign: TextAlign.center,
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
                style: TextStyle(color: Palette.black)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Palette.redDelete,
            ),
            onPressed: () {
              Navigator.of(context).pop(true); // User confirmed
            },
            child: Text(LocalizationService.translateFromGeneral('confirm'),
                style: TextStyle(color: Palette.white)),
          ),
        ],
      );
    },
  );
  return confirmCancel;
}
