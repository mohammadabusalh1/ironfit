import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/custom_text_widget.dart';

class MainPopUp extends StatelessWidget {
  final String title;
  final String content;
  final String? subContent;
  final String? image;
  final String confirmText;
  final String cancelText;
  final List<String>? textFieldHints;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  const MainPopUp({
    super.key,
    required this.title,
    required this.content,
    this.subContent,
    this.confirmText = "Confirm",
    this.cancelText = "Cancel",
    this.onConfirm,
    this.onCancel,
    this.image,
    this.textFieldHints,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Dialog(
          backgroundColor: Palette.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          elevation: 16,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height *
                      0.8, // Limit the height
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidget(
                      text: title,
                      color: Palette.mainAppColor,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 12.0),
                    CustomTextWidget(
                      text: content,
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                    if (subContent != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: CustomTextWidget(
                          text: subContent!,
                          fontSize: 14.0,
                          color: Colors.white70,
                        ),
                      ),
                    const SizedBox(height: 24.0),
                    if (textFieldHints != null && textFieldHints!.isNotEmpty)
                      ...textFieldHints!.map(
                        (hint) => Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: hint,
                              hintStyle: const TextStyle(color: Colors.white70),
                              filled: true,
                              fillColor: Palette.subTitleGrey.withOpacity(0.2),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0),
                            ),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    const SizedBox(height: 12.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: onCancel ?? () => Get.back(),
                          child: CustomTextWidget(
                            text: cancelText,
                            color: Palette.mainAppColor,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Palette.mainAppColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 12.0),
                          ),
                          onPressed: onConfirm ?? () => Get.back(),
                          child: Text(
                            confirmText,
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
