import 'package:caregiver_hub/caregiver/screens/caregiver_list_screen.dart';
import 'package:caregiver_hub/main.dart';
import 'package:caregiver_hub/shared/constants/pagination.dart';
import 'package:caregiver_hub/shared/models/caregiver.dart';
import 'package:caregiver_hub/shared/models/service.dart';
import 'package:caregiver_hub/shared/models/skill.dart';
import 'package:caregiver_hub/shared/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CaregiverService {
  final _firestore = FirebaseFirestore.instance;

  final _authService = getIt<AuthService>();

  Stream<List<Caregiver>> fetchCaregivers({int size = pageSize}) {
    return _firestore
        .collection('users')
        .where('showAsCaregiver', isEqualTo: true)
        .where(FieldPath.documentId, isNotEqualTo: _authService.currentUserId())
        .limit(size)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (item) => Caregiver(
                  id: item.id,
                  name: item['fullName'],
                  imageURL: item['imageURL'],
                  phone: item['phone'],
                  bio: item['bio'],
                  startPrice: item['startPrice'],
                  endPrice: item['endPrice'],
                  rating: (item['rating'] as int).toDouble(),
                  services: ((item['services'] as List?) ?? [])
                      .map(
                        (service) => Service(
                          id: service['id'],
                          description: service['description'],
                        ),
                      )
                      .toList(),
                  skills: ((item['skills'] as List?) ?? [])
                      .map(
                        (skill) => Skill(
                          id: skill['id'],
                          description: skill['description'],
                        ),
                      )
                      .toList(),
                ),
              )
              .toList(),
        );
  }
}
