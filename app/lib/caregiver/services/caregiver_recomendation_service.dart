import 'package:caregiver_hub/caregiver/models/caregiver_recomendation_card_data.dart';
import 'package:caregiver_hub/caregiver/models/caregiver_recomendation_form_data.dart';
import 'package:caregiver_hub/shared/services/user_service.dart';
import 'package:caregiver_hub/main.dart';
import 'package:caregiver_hub/shared/utils/io.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CaregiverRecomendationService {
  final _firestore = FirebaseFirestore.instance;
  final _userService = getIt<UserService>();

  Stream<CaregiverRecomendationFormData> fetchCaregiverRecomendationFormData({
    required String employerId,
    required String caregiverId,
  }) {
    return _firestore
        .collection('caregiverRecomendations')
        .where('employerId', isEqualTo: employerId)
        .where('caregiverId', isEqualTo: caregiverId)
        .get()
        .asStream()
        .map((snapshot) => snapshot.size > 0 ? snapshot.docs[0] : null)
        .map(
          (snapshot) => CaregiverRecomendationFormData(
            id: snapshot?.id,
            rating: snapshot?['rating'],
            recomendation: snapshot?['recomendation'],
            caregiverId: caregiverId,
          ),
        );
  }

  Future<void> createCaregiverRecomendation({
    required String employerId,
    required String caregiverId,
    required String? recomendation,
    required int rating,
  }) async {
    handleFirebaseExceptions(() async {
      await _firestore.collection('caregiverRecomendations').add({
        'employerId': employerId,
        'caregiverId': caregiverId,
        'recomendation': recomendation,
        'rating': rating,
        'createdAt': DateTime.now(),
        'updatedAt': DateTime.now(),
      });
    });
  }

  Future<void> updateCaregiverRecomendation({
    required String id,
    required String? recomendation,
    required int rating,
  }) async {
    handleFirebaseExceptions(() async {
      await _firestore.collection('caregiverRecomendations').doc(id).update({
        'recomendation': recomendation,
        'rating': rating,
        'updatedAt': DateTime.now(),
      });
    });
  }

  Stream<List<CaregiverRecomendationCardData>>
      fetchCaregiverRecomendationCards({
    required String caregiverId,
    required int size,
  }) {
    return _firestore
        .collection('caregiverRecomendations')
        .where('caregiverId', isEqualTo: caregiverId)
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (item) => CaregiverRecomendationCardData(
                  rating: item['rating'],
                  employerId: item['employerId'],
                  recomendation: item['recomendation'],
                ),
              )
              .toList(),
        );
  }
}
