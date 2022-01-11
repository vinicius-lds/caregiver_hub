import 'package:caregiver_hub/social/models/chat_message.dart';
import 'package:flutter/foundation.dart';

class ChatMessageProvider with ChangeNotifier {
  Stream<List<ChatMessage>> listStream({
    required String userId,
    required String otherUserId,
  }) {
    return Stream.value(_loadMockData(userId, otherUserId));
  }
}

List<ChatMessage> _loadMockData(String userId, String otherUserId) {
  return [
    ChatMessage(
      id: '11',
      content: 'Mensagem 11',
      sendingUserId: userId,
      recievingUserId: otherUserId,
    ),
    ChatMessage(
      id: '21',
      content: 'Mensagem 21',
      sendingUserId: otherUserId,
      recievingUserId: userId,
    ),
    ChatMessage(
      id: '12',
      content: 'Mensagem 12',
      sendingUserId: userId,
      recievingUserId: otherUserId,
    ),
    ChatMessage(
      id: '22',
      content: 'Mensagem 22',
      sendingUserId: otherUserId,
      recievingUserId: userId,
    ),
    ChatMessage(
      id: '13',
      content: 'Mensagem 13',
      sendingUserId: userId,
      recievingUserId: otherUserId,
    ),
    ChatMessage(
      id: '23',
      content: 'Mensagem 23',
      sendingUserId: otherUserId,
      recievingUserId: userId,
    ),
    ChatMessage(
      id: '14',
      content: 'Mensagem 14',
      sendingUserId: userId,
      recievingUserId: otherUserId,
    ),
    ChatMessage(
      id: '24',
      content: 'Mensagem 24',
      sendingUserId: otherUserId,
      recievingUserId: userId,
    ),
    ChatMessage(
      id: '15',
      content: 'Mensagem 15',
      sendingUserId: userId,
      recievingUserId: otherUserId,
    ),
    ChatMessage(
      id: '25',
      content: 'Mensagem 25',
      sendingUserId: otherUserId,
      recievingUserId: userId,
    ),
    ChatMessage(
      id: '16',
      content: 'Mensagem 16',
      sendingUserId: userId,
      recievingUserId: otherUserId,
    ),
    ChatMessage(
      id: '26',
      content: 'Mensagem 26',
      sendingUserId: otherUserId,
      recievingUserId: userId,
    ),
    ChatMessage(
      id: '17',
      content: 'Mensagem 17',
      sendingUserId: userId,
      recievingUserId: otherUserId,
    ),
    ChatMessage(
      id: '27',
      content: 'Mensagem 27',
      sendingUserId: otherUserId,
      recievingUserId: userId,
    ),
    ChatMessage(
      id: '18',
      content: 'Mensagem 18',
      sendingUserId: userId,
      recievingUserId: otherUserId,
    ),
    ChatMessage(
      id: '28',
      content: 'Mensagem 28',
      sendingUserId: otherUserId,
      recievingUserId: userId,
    ),
    ChatMessage(
      id: '19',
      content: 'Mensagem 19',
      sendingUserId: userId,
      recievingUserId: otherUserId,
    ),
    ChatMessage(
      id: '29',
      content: 'Mensagem 29',
      sendingUserId: otherUserId,
      recievingUserId: userId,
    ),
    ChatMessage(
      id: '30',
      content: 'Mensagem 30',
      sendingUserId: userId,
      recievingUserId: otherUserId,
    ),
    ChatMessage(
      id: '40',
      content: 'Mensagem 40',
      sendingUserId: otherUserId,
      recievingUserId: userId,
    ),
    ChatMessage(
      id: '31',
      content: 'Mensagem 31',
      sendingUserId: userId,
      recievingUserId: otherUserId,
    ),
    ChatMessage(
      id: '41',
      content: 'Mensagem 41',
      sendingUserId: otherUserId,
      recievingUserId: userId,
    ),
    ChatMessage(
      id: '32',
      content: 'Mensagem 32',
      sendingUserId: userId,
      recievingUserId: otherUserId,
    ),
    ChatMessage(
      id: '42',
      content: 'Mensagem 42',
      sendingUserId: otherUserId,
      recievingUserId: userId,
    ),
    ChatMessage(
      id: '33',
      content: 'Mensagem 33',
      sendingUserId: userId,
      recievingUserId: otherUserId,
    ),
    ChatMessage(
      id: '43',
      content: 'Mensagem 43',
      sendingUserId: otherUserId,
      recievingUserId: userId,
    ),
    ChatMessage(
      id: '34',
      content: 'Mensagem 34',
      sendingUserId: userId,
      recievingUserId: otherUserId,
    ),
    ChatMessage(
      id: '44',
      content: 'Mensagem 44',
      sendingUserId: otherUserId,
      recievingUserId: userId,
    ),
    ChatMessage(
      id: '35',
      content: 'Mensagem 35',
      sendingUserId: userId,
      recievingUserId: otherUserId,
    ),
    ChatMessage(
      id: '45',
      content: 'Mensagem 45',
      sendingUserId: otherUserId,
      recievingUserId: userId,
    ),
    ChatMessage(
      id: '36',
      content: 'Mensagem 36',
      sendingUserId: userId,
      recievingUserId: otherUserId,
    ),
    ChatMessage(
      id: '46',
      content: 'Mensagem 46',
      sendingUserId: otherUserId,
      recievingUserId: userId,
    ),
    ChatMessage(
      id: '37',
      content: 'Mensagem 37',
      sendingUserId: userId,
      recievingUserId: otherUserId,
    ),
    ChatMessage(
      id: '47',
      content: 'Mensagem 47',
      sendingUserId: otherUserId,
      recievingUserId: userId,
    ),
  ];
}
