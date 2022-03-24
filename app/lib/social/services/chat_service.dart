import 'package:caregiver_hub/shared/utils/io.dart';
import 'package:caregiver_hub/social/models/chat_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final _firestore = FirebaseFirestore.instance;

  Future<void> pushMessage(
    String message, {
    required String caregiverId,
    required String employerId,
    required String createdBy,
  }) async {
    handleFirebaseExceptions(() async {
      await _firestore.collection('chat').add({
        'content': message,
        'createdAt': Timestamp.now(),
        'caregiverId': caregiverId,
        'employerId': employerId,
        'createdBy': createdBy,
      });
    });
  }

  Stream<List<ChatMessage>> fetchChatMessages({
    required String employerId,
    required String caregiverId,
  }) {
    return _firestore
        .collection('chat')
        .where('employerId', isEqualTo: employerId)
        .where('caregiverId', isEqualTo: caregiverId)
        .orderBy('createdAt', descending: false)
        .limit(100)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (item) => ChatMessage(
                  id: item.id,
                  content: item['content'],
                  employerId: item['employerId'],
                  caregiverId: item['caregiverId'],
                  createdBy: item['createdBy'],
                ),
              )
              .toList(),
        );
  }
}
