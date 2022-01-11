class ChatMessage {
  final String id;
  final String content;
  final String sendingUserId;
  final String recievingUserId;

  const ChatMessage({
    required this.id,
    required this.content,
    required this.sendingUserId,
    required this.recievingUserId,
  });
}
