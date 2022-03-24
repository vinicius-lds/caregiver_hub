import 'package:cloud_firestore/cloud_firestore.dart';

class OtherUserChatData {
  final String? otherUserImageURL;
  final String otherUserName;
  final String otherUserId;

  const OtherUserChatData({
    required this.otherUserImageURL,
    required this.otherUserName,
    required this.otherUserId,
  });

  factory OtherUserChatData.fromUserDocumentSnapshot(DocumentSnapshot doc) {
    return OtherUserChatData(
      otherUserId: doc.id,
      otherUserImageURL: doc.get('imageURL'),
      otherUserName: doc.get('fullName'),
    );
  }

  Map<String, String?> toMap() {
    return {
      'otherUserImageURL': otherUserImageURL,
      'otherUserName': otherUserName,
      'otherUserId': otherUserId,
    };
  }
}
