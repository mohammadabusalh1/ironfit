import 'package:flutter/material.dart';
import 'package:ironfit/core/models/notification_item.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ironfit/core/services/firebase_notification_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseNotificationService _notificationService = FirebaseNotificationService();
  bool isCoach = false; // Set this based on user role

  @override
  void initState() {
    super.initState();
    _checkUserRole();
  }

  Future<void> _checkUserRole() async {
    // Check if current user is a coach
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('coaches')
          .doc(user.uid)
          .get();
      setState(() {
        isCoach = doc.exists;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocalizationService.translateFromGeneral('notifications'),
          style: AppStyles.textCairo(18, Palette.white, FontWeight.bold),
        ),
        backgroundColor: Palette.mainAppColor,
      ),
      body: Column(
        children: [
          SizedBox(height: 24,),
          Expanded(
            child: StreamBuilder<List<NotificationItem>>(
              stream: _notificationService.getNotificationsStream(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final notifications = snapshot.data!;
                if (notifications.isEmpty) {
                  return Center(
                    child: Text(
                      LocalizationService.translateFromGeneral('noNotifications'),
                      style: AppStyles.textCairo(16, Palette.gray, FontWeight.normal),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    return _buildNotificationCard(notifications[index]);
                  },
                );
              },
            ),
          ),
          if (isCoach) _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(NotificationItem notification) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () => _notificationService.markAsRead(notification.id),
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
                    _formatTime(notification.time),
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

  void _sendNotification() async {
    if (_messageController.text.trim().isNotEmpty) {
      try {
        await _notificationService.sendNotificationToTrainees(
          LocalizationService.translateFromGeneral('coachAnnouncement'),
          _messageController.text,
        );
        _messageController.clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error sending notification: $e')),
        );
      }
    }
  }

  String _formatTime(DateTime time) {
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

  Widget _buildMessageInput() {
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
            controller: _messageController,
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
            onPressed: _sendNotification,
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