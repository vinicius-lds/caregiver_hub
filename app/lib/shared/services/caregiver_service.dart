import 'package:caregiver_hub/main.dart';
import 'package:caregiver_hub/shared/constants/pagination.dart';
import 'package:caregiver_hub/shared/models/caregiver.dart';
import 'package:caregiver_hub/shared/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CaregiverService {
  final _firestore = FirebaseFirestore.instance;

  final _authService = getIt<AuthService>();

  Stream<Caregiver> fetchCaregiver({required String id}) {
    return _firestore
        .collection('users')
        .doc(id)
        .get()
        .asStream()
        .map((snapshot) => Caregiver.fromDocumentSnapshot(snapshot));
  }

  Stream<List<Caregiver>> fetchCaregivers({int size = pageSize}) {
    return _firestore
        .collection('users')
        .where('showAsCaregiver', isEqualTo: true)
        .where(FieldPath.documentId, isNotEqualTo: _authService.currentUserId())
        .limit(size)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((item) => Caregiver.fromDocumentSnapshot(item))
              .toList(),
        );
  }
}
