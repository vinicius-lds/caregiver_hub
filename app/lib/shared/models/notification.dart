import 'package:caregiver_hub/shared/models/notification_type.dart';

class Notification {
  final NotificationType type;
  final String title;
  final String content;
  final Map<String, String> data;
  final String fromUserId;
  final String toUserId;

  const Notification({
    required this.type,
    required this.title,
    required this.content,
    required this.data,
    required this.fromUserId,
    required this.toUserId,
  });

  factory Notification.fromMap(Map<String, dynamic> map) {
    return Notification(
      type: NotificationType.fromString(map['type']),
      title: map['title'],
      content: map['content'],
      data: map['data'],
      fromUserId: map['fromUserId'],
      toUserId: map['toUserId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type.key,
      'title': title,
      'content': content,
      'data': data,
      'fromUserId': fromUserId,
      'toUserId': toUserId,
    };
  }
}
