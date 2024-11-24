import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';
import 'package:ironfit/features/ChatScreen/controllers/chat_controller.dart';

class MessageInputView extends StatelessWidget {
  final ChatController controller;

  const MessageInputView({required this.controller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
          ),
        ],
      ),
      child: Column(
        children: [
          TextField(
            controller: controller.messageController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: LocalizationService.translateFromGeneral('typeAnnouncement'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey[100],
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => controller.sendNotification(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Palette.mainAppColor,
              minimumSize: const Size(double.infinity, 45),
            ),
            child: Text(
              LocalizationService.translateFromGeneral('sendToAllTrainers'),
              style: AppStyles.textCairo(16, Palette.white, FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
} 