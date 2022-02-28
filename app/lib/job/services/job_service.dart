import 'package:caregiver_hub/job/models/job.dart';
import 'package:caregiver_hub/shared/constants/pagination.dart';
import 'package:caregiver_hub/shared/models/place_coordinates.dart';
import 'package:caregiver_hub/shared/models/service.dart';
import 'package:caregiver_hub/shared/utils/io.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class JobService {
  final _firestore = FirebaseFirestore.instance;

  Future<void> makeProposal({
    required String caregiverId,
    required String employerId,
    required PlaceCoordinates placeCoordinates,
    required DateTime startDate,
    required DateTime endDate,
    required List<Service> services,
    required double price,
  }) async {
    handleFirebaseExceptions(() async {
      await _firestore.collection('jobs').add({
        'caregiverId': caregiverId,
        'employerId': employerId,
        'placeCoordinates': {
          'id': placeCoordinates.id,
          'description': placeCoordinates.description,
          'coordinates': {
            'latitude': placeCoordinates.coordinates.latitude,
            'longitude': placeCoordinates.coordinates.longitude,
          },
        },
        'startDate': startDate,
        'endDate': endDate,
        'services': services.map((service) => service.key).toList(),
        'price': price,
        'isCanceled': false,
        'isApprovedByEmployer': true,
        'isApprovedByCaregiver': false,
        'createdAt': DateTime.now(),
      });
    });
  }

  Future<void> editProposal({
    required String jobId,
    required PlaceCoordinates placeCoordinates,
    required DateTime startDate,
    required DateTime endDate,
    required List<Service> services,
    required double price,
    required bool isCaregiver,
  }) async {
    handleFirebaseExceptions(() async {
      await _firestore.collection('jobs').doc(jobId).update({
        'placeCoordinates': {
          'id': placeCoordinates.id,
          'description': placeCoordinates.description,
          'coordinates': {
            'latitude': placeCoordinates.coordinates.latitude,
            'longitude': placeCoordinates.coordinates.longitude,
          },
        },
        'startDate': startDate,
        'endDate': endDate,
        'services': services.map((service) => service.key).toList(),
        'price': price,
        'isCanceled': false,
        'isApprovedByEmployer': !isCaregiver,
        'isApprovedByCaregiver': isCaregiver
      });
    });
  }

  Stream<List<Job>> fetchJobs({
    required String? caregiverId,
    required String? employerId,
    int size = pageSize,
  }) {
    assert(
      (caregiverId == null || employerId == null) &&
          (caregiverId != null || employerId != null),
      'Only the caregiverId or the employerId should be provider.',
    );
    return _firestore
        .collection('jobs')
        .where(
          caregiverId != null ? 'caregiverId' : 'employerId',
          isEqualTo: caregiverId ?? employerId,
        )
        .limit(size)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (item) => Job(
                  id: item.id,
                  caregiverId: item['caregiverId'],
                  employerId: item['employerId'],
                  startDate: (item['startDate'] as Timestamp).toDate(),
                  endDate: (item['endDate'] as Timestamp).toDate(),
                  services: (item['services'] as List)
                      .map((service) => Service.fromKey(service['key']))
                      .toList(),
                  price: item['price'],
                  isCanceled: item['isCanceled'],
                  isApprovedByEmployer: item['isApprovedByEmployer'],
                  isApprovedByCaregiver: item['isApprovedByCaregiver'],
                  placeCoordinates: PlaceCoordinates(
                    id: item['placeCoordinates']['description'],
                    description: item['placeCoordinates']['description'],
                    coordinates: LatLng(
                      item['placeCoordinates']['coordinates']['latitude'],
                      item['placeCoordinates']['coordinates']['longitude'],
                    ),
                  ),
                ),
              )
              .toList(),
        );
  }

  Future<void> accept({
    required String jobId,
    required bool isCaregiver,
  }) async {
    handleFirebaseExceptions(() async {
      final payload = isCaregiver
          ? {'isApprovedByCaregiver': true}
          : {'isApprovedByEmployer': true};
      await _firestore.collection('jobs').doc(jobId).update(payload);
    });
  }

  Future<void> cancel({required String jobId}) async {
    handleFirebaseExceptions(() async {
      await _firestore
          .collection('jobs')
          .doc(jobId)
          .update({'isCanceled': true});
    });
  }
}
