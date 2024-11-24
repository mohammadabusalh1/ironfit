import 'package:flutter/material.dart';
import 'package:ironfit/core/models/notification_item.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';
import 'package:ironfit/features/ChatScreen/controllers/chat_controller.dart';
import 'package:ironfit/features/ChatScreen/views/message_input_view.dart';
import 'package:ironfit/features/ChatScreen/views/notification_card.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatController _controller = ChatController();

  @override
  void initState() {
    super.initState();
    _controller.checkUserRole();
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
          SizedBox(height: 24),
          Expanded(
            child: StreamBuilder<List<NotificationItem>>(
              stream: _controller.notificationsStream,
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
                      LocalizationService.translateFromGeneral(
                          'noNotifications'),
                      style: AppStyles.textCairo(
                          16, Palette.gray, FontWeight.normal),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    return NotificationCardView(
                      notification: notifications[index],
                      controller: _controller,
                    );
                  },
                );
              },
            ),
          ),
          MessageInputView(controller: _controller),
        ],
      ),
    );
  }
}
