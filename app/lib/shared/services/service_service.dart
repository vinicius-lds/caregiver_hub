import 'package:caregiver_hub/shared/models/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceService {
  final _firestore = FirebaseFirestore.instance;

  Stream<List<Service>> fetchServices() {
    return _firestore
        .collection('services')
        .orderBy('description')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (item) => Service(
                  id: item.id,
                  description: item.data()['description'],
                ),
              )
              .toList(),
        );
  }
}
