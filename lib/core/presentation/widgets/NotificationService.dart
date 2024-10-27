// lib/core/presentation/widgets/NotificationService.dart

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  Future<void> init() async {
    // Initialize notifications
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Initialize Workmanager for daily checks
    await Workmanager().initialize(callbackDispatcher);
    await setupDailyCheck();
  }

  // Set up daily background task
  Future<void> setupDailyCheck() async {
    await Workmanager().registerPeriodicTask(
      'subscription-check',
      'dailySubscriptionCheck',
      frequency: const Duration(days: 1),
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
      existingWorkPolicy: ExistingWorkPolicy.replace,
    );
  }

  Future<void> showNotification({
    required String title,
    required String body,
    int id = 0,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'subscription_channel',
      'Subscription Notifications',
      channelDescription: 'Notifications for subscription expiry',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  Future<void> checkAndNotifySubscription(String userId) async {
    try {
      // Store last check time
      final prefs = await SharedPreferences.getInstance();
      final lastCheck = prefs.getString('lastSubscriptionCheck');
      final now = DateTime.now();

      // Only check once per day
      if (lastCheck != null) {
        final lastCheckDate = DateTime.parse(lastCheck);
        if (now.difference(lastCheckDate).inDays < 1) {
          return;
        }
      }

      // Get user document
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('trainees')
          .doc(userId)
          .get();

      if (!userSnapshot.exists) return;

      String? coachId = userSnapshot.get('coachId');
      String? subscriptionId = userSnapshot.get('subscriptionId');

      if (coachId == null || subscriptionId == null) return;

      // Get subscription document
      DocumentSnapshot subscriptionSnapshot = await FirebaseFirestore.instance
          .collection('coaches')
          .doc(coachId)
          .collection('subscriptions')
          .doc(subscriptionId)
          .get();

      if (subscriptionSnapshot.exists) {
        String endDateTimestamp = subscriptionSnapshot.get('endDate');
        DateTime endDate = DateTime.parse(endDateTimestamp);

        int daysUntilExpiry = endDate.difference(now).inDays;

        // Check various subscription states
        if (daysUntilExpiry <= 0) {
          // Subscription expired
          await showNotification(
            title: "إنتهى الاشتراك",
            body: "يرجى تجديد الاشتراك",
          );
        } else if (daysUntilExpiry <= 7) {
          // Subscription ending soon
          await showNotification(
            title: "تنبيه انتهاء الاشتراك",
            body: "اشتراكك سينتهي خلال $daysUntilExpiry أيام",
          );
        } else if (daysUntilExpiry <= 14) {
          // Early warning
          await showNotification(
            title: "تنبيه مبكر",
            body: "اشتراكك سينتهي خلال أسبوعين",
          );
        }

        // Update last check time
        await prefs.setString('lastSubscriptionCheck', now.toIso8601String());
      }
    } catch (e) {
      print('Error checking subscription: $e');
    }
  }

  Future<void> setupSubscriptionListener(String userId) async {
    try {
      // Initial check
      await checkAndNotifySubscription(userId);

      // Set up real-time listener
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('trainees')
          .doc(userId)
          .get();

      FirebaseFirestore.instance
          .collection('coaches')
          .doc(userSnapshot.get('coachId'))
          .collection('subscriptions')
          .doc(userSnapshot.get('subscriptionId'))
          .snapshots()
          .listen((DocumentSnapshot snapshot) {
        if (snapshot.exists) {
          checkAndNotifySubscription(userId);
        }
      });
    } catch (e) {
      print('Error setting up subscription listener: $e');
    }
  }
}

// Background task callback
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');

      if (userId != null) {
        final notificationService = NotificationService();
        await notificationService.checkAndNotifySubscription(userId);
      }
      return true;
    } catch (e) {
      print('Background task error: $e');
      return false;
    }
  });
}
