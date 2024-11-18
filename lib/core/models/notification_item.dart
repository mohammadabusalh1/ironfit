class NotificationItem {
  final String id;
  final String title;
  final String message;
  final DateTime time;
  final String senderId;
  final List<String> receiverIds;
  bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.senderId,
    required this.receiverIds,
    this.isRead = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'time': time.toIso8601String(),
      'senderId': senderId,
      'receiverIds': receiverIds,
      'isRead': isRead,
    };
  }

  factory NotificationItem.fromMap(Map<String, dynamic> map) {
    return NotificationItem(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      message: map['message'] ?? '',
      time: DateTime.parse(map['time']),
      senderId: map['senderId'] ?? '',
      receiverIds: List<String>.from(map['receiverIds'] ?? []),
      isRead: map['isRead'] ?? false,
    );
  }
}
