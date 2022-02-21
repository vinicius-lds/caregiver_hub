import 'package:caregiver_hub/main.dart';
import 'package:caregiver_hub/shared/constants/pagination.dart';
import 'package:caregiver_hub/shared/models/caregiver.dart';
import 'package:caregiver_hub/shared/models/place_coordinates.dart';
import 'package:caregiver_hub/shared/models/service.dart';
import 'package:caregiver_hub/shared/models/skill.dart';
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

  Stream<List<Caregiver>> fetchCaregivers({
    required String idIgnore,
    PlaceCoordinates? placeCoordinates,
    List<Service>? services,
    List<Skill>? skills,
    int size = pageSize,
  }) {
    var q = _firestore
        .collection('users')
        .where('showAsCaregiver', isEqualTo: true);

    if (idIgnore.trim() != '') {
      q = q.where(FieldPath.documentId, isNotEqualTo: idIgnore);
    }

    final servicesFilter = (services ?? [])
        .map(
          (item) => {
            'id': item.id,
            'description': item.description,
          },
        )
        .toList();
    if (servicesFilter.isNotEmpty) {
      q = q.where('services', arrayContainsAny: servicesFilter);
    }

    final skillsFilter = (skills ?? [])
        .map(
          (item) => {
            'id': item.id,
            'description': item.description,
          },
        )
        .toList();
    if (skillsFilter.isNotEmpty) {
      q = q.where('skills', arrayContainsAny: skillsFilter);
    }

    return q.limit(size).snapshots().map(
          (snapshot) => snapshot.docs
              .map((item) => Caregiver.fromDocumentSnapshot(item))
              .toList(),
        );
  }
}
