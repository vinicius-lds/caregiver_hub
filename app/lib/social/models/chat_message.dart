class ChatMessage {
  final String id;
  final String content;
  final String employerId;
  final String caregiverId;

  const ChatMessage({
    required this.id,
    required this.content,
    required this.employerId,
    required this.caregiverId,
  });
}
