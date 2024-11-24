import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ironfit/core/models/notification_item.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';
import 'package:ironfit/core/services/firebase_notification_service.dart';

class ChatController extends ChangeNotifier {
  final FirebaseNotificationService _notificationService = FirebaseNotificationService();
  final TextEditingController messageController = TextEditingController();
  bool isCoach = false;

  Stream<List<NotificationItem>> get notificationsStream => 
      _notificationService.getNotificationsStream();

  Future<void> checkUserRole() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('coaches')
          .doc(user.uid)
          .get();
      isCoach = doc.exists;
      notifyListeners();
    }
  }

  Future<void> sendNotification() async {
    if (messageController.text.trim().isNotEmpty) {
      await _notificationService.sendNotificationToTrainees(
        LocalizationService.translateFromGeneral('coachAnnouncement'),
        messageController.text,
      );
      messageController.clear();
    }
  }

  void markAsRead(String notificationId) {
    _notificationService.markAsRead(notificationId);
  }

  String formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
} 