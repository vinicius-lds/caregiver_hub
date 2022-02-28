import 'package:caregiver_hub/main.dart';
import 'package:caregiver_hub/shared/constants/pagination.dart';
import 'package:caregiver_hub/shared/models/caregiver.dart';
import 'package:caregiver_hub/shared/models/location.dart';
import 'package:caregiver_hub/shared/models/service.dart';
import 'package:caregiver_hub/shared/models/skill.dart';
import 'package:caregiver_hub/shared/services/auth_service.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CaregiverService {
  final _firestore = FirebaseFirestore.instance;
  final _geo = getIt<Geoflutterfire>();

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
    Location? location,
    List<Service>? services,
    List<Skill>? skills,
    int size = pageSize,
  }) {
    if (location == null) {
      return const Stream.empty();
    }

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

    if (location != null) {
      final coordinates = location.coordinates;
      final geoHash = _geo
          .point(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude,
          )
          .hash;
      q = q.where(
        'location.geoHashes',
        arrayContainsAny: [
          geoHash.substring(0, 2),
          geoHash.substring(0, 3),
          geoHash.substring(0, 4),
          geoHash.substring(0, 5),
          geoHash.substring(0, 6),
          geoHash.substring(0, 7),
          geoHash.substring(0, 8),
        ],
      );
    }

    return q.limit(size).snapshots().map(
          (snapshot) => snapshot.docs
              .map((item) => Caregiver.fromDocumentSnapshot(item))
              .toList(),
        );
  }
}
