class NotificationType {
  static const NotificationType chat = NotificationType._('CHAT');
  static const NotificationType jobChange = NotificationType._('JOB_CHANGE');

  static List<NotificationType> get values {
    return [chat, jobChange];
  }

  static NotificationType fromString(String value) {
    return values.firstWhere((element) => element.key == value);
  }

  final String key;

  const NotificationType._(this.key);
}
