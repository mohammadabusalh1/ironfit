import 'package:flutter/material.dart';
import 'package:ironfit/core/models/notification_item.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/features/ChatScreen/controllers/chat_controller.dart';

class NotificationCardView extends StatelessWidget {
  final NotificationItem notification;
  final ChatController controller;

  const NotificationCardView({
    required this.notification,
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () => controller.markAsRead(notification.id),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: notification.isRead ? null : Palette.mainAppColorBack.withOpacity(0.05),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.notifications,
                    color: notification.isRead ? Palette.gray : Palette.mainAppColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    controller.formatTime(notification.time),
                    style: AppStyles.textCairo(12, Palette.gray, FontWeight.normal),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                notification.title,
                style: AppStyles.textCairo(
                  16,
                  Palette.black,
                  notification.isRead ? FontWeight.normal : FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                notification.message,
                style: AppStyles.textCairo(14, Palette.black, FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 