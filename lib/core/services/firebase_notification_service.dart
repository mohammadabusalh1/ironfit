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
    return trainees.docs.map((doc) => doc.data()['userId'] as String).toList();
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
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await _firestore
            .collection('notifications')
            .add(notification.toMap());
      }
    } catch (e) {
      print('Error sending notification: $e');
      rethrow;
    }
  }

  // Get notifications for current user
  Future<List<NotificationItem>> getNotificationsForCoach() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return [];

    var data = await _firestore
        .collection('notifications')
        .orderBy('time', descending: true)
        .where('senderId', isEqualTo: userId)
        .get();

    return data.docs
        .map((doc) => NotificationItem.fromMap(doc.data()))
        .toList();
  }

  Stream<List<NotificationItem>> getNotificationsForTrainee() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return Stream.value([]);

    return _firestore
        .collection('notifications')
        .orderBy('time', descending: true)
        .where('receiverIds', arrayContains: userId)
        .snapshots()
        .map((snapshot) {
      // Show local notification for new messages
      for (var change in snapshot.docChanges) {
        if (change.type == DocumentChangeType.added) {
          final notification = NotificationItem.fromMap(change.doc.data()!);
          // Only show notification for new messages
          if (DateTime.now().difference(notification.time).inMinutes < 1) {
            NotificationService.showNotification(
              title: notification.title,
              body: notification.message,
            );
          }
        }
      }
      return snapshot.docs
          .map((doc) => NotificationItem.fromMap(doc.data()))
          .toList();
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

  Stream<List<NotificationItem>> getNotificationsStream() {
    return FirebaseFirestore.instance
        .collection('notifications')
        .orderBy('time', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc){
              return NotificationItem.fromMap(doc.data());
            })
            .toList());
  }
}
