import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ironfit/core/services/notification_service.dart';
import 'package:uuid/uuid.dart';
import '../models/notification_item.dart';

class FirebaseNotificationService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<List<String>> getTraineesIds() async {
    final coachId = _auth.currentUser!.uid;
    final trainees = await _firestore
        .collection('subscriptions')
        .where('coachId', isEqualTo: coachId)
        .get();
    return trainees.docs
        .map((doc) => doc.data()['traineeId'] as String)
        .toList();
  }

  // Send notification to all trainers
  Future<void> sendNotificationToTrainees(String title, String message) async {
    try {
      final notification = NotificationItem(
        id: const Uuid().v4(),
        title: title,
        message: message,
        time: DateTime.now(),
        senderId: _auth.currentUser!.uid,
        receiverIds: await getTraineesIds(), // Empty means all trainees
        isRead: false,
      );

      await _firestore
          .collection('notifications')
          .doc(notification.id)
          .set(notification.toMap());

      // Also trigger push notification
      await NotificationService.showNotification(
        title: title,
        body: message,
      );
    } catch (e) {
      print('Error sending notification: $e');
      rethrow;
    }
  }

  // Get notifications for current user
  Stream<List<NotificationItem>> getNotifications() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return Stream.value([]);

    return _firestore
        .collection('notifications')
        .orderBy('time', descending: true)
        .where('senderId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.whereType<NotificationItem>().toList();
    });
  }

  // Mark notification as read
  Future<void> markAsRead(String notificationId) async {
    try {
      await _firestore
          .collection('notifications')
          .doc(notificationId)
          .update({'isRead': true});
    } catch (e) {
      print('Error marking notification as read: $e');
      rethrow;
    }
  }
}
