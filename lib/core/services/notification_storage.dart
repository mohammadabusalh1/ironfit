import 'dart:convert';

import 'package:ironfit/core/models/notification_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationStorage {
  static const String _key = 'notifications';

  static Future<void> saveNotifications(List<NotificationItem> notifications) async {
    final prefs = await SharedPreferences.getInstance();
    final notificationsJson = notifications.map((n) => {
      'title': n.title,
      'message': n.message,
      'time': n.time.toIso8601String(),
      'isRead': n.isRead,
    }).toList();
    await prefs.setString(_key, json.encode(notificationsJson));
  }

  static Future<List<NotificationItem>> getNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final notificationsJson = prefs.getString(_key);
    if (notificationsJson == null) return [];

    final List<dynamic> decoded = json.decode(notificationsJson);
    return decoded.map((n) => NotificationItem(
      id: n['id'],
      title: n['title'],
      message: n['message'],
      time: DateTime.parse(n['time']),
      isRead: n['isRead'],
      senderId: n['senderId'],
      receiverIds: n['receiverIds'],
    )).toList();
  }
} 