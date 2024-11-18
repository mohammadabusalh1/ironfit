import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<NotificationMessage> _messages = [];

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
          // Notification messages list
          Expanded(
            child: _messages.isEmpty
                ? Center(
                    child: Text(
                      LocalizationService.translateFromGeneral('noNotifications'),
                      style: AppStyles.textCairo(
                        16,
                        Palette.gray,
                        FontWeight.normal,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return _buildNotificationCard(_messages[index]);
                    },
                  ),
          ),
          // Only show input if user is a coach
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(NotificationMessage message) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.notifications, color: Palette.mainAppColor),
                const SizedBox(width: 8),
                Text(
                  message.timestamp.toString(),
                  style: AppStyles.textCairo(12, Palette.gray, FontWeight.normal),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              message.text,
              style: AppStyles.textCairo(14, Palette.black, FontWeight.normal),
            ),
          ],
        ),
      ),
    );
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

  void _sendNotification() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.insert(
          0,
          NotificationMessage(
            text: _messageController.text,
            timestamp: DateTime.now(),
          ),
        );
      });
      _messageController.clear();
    }
  }
}

class NotificationMessage {
  final String text;
  final DateTime timestamp;

  NotificationMessage({
    required this.text,
    required this.timestamp,
  });
}