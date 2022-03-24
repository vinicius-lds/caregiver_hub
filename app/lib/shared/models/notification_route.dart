class NotificationRoute {
  final String route;
  final bool receivedNotificationAsCaregiver;
  final Map<String, dynamic> arguments;

  const NotificationRoute({
    required this.route,
    required this.receivedNotificationAsCaregiver,
    required this.arguments,
  });
}
