class ChatMessage {
  final String id;
  final String content;
  final String employerId;
  final String caregiverId;
  final String createdBy;

  const ChatMessage({
    required this.id,
    required this.content,
    required this.employerId,
    required this.caregiverId,
    required this.createdBy,
  });
}
