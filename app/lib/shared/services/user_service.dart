import 'dart:io';

import 'package:caregiver_hub/main.dart';
import 'package:caregiver_hub/shared/exceptions/service_exception.dart';
import 'package:caregiver_hub/shared/models/caregiver_recomendation_user_data.dart';
import 'package:caregiver_hub/shared/models/job_user_data.dart';
import 'package:caregiver_hub/shared/models/location.dart';
import 'package:caregiver_hub/shared/models/service.dart';
import 'package:caregiver_hub/shared/models/skill.dart';
import 'package:caregiver_hub/shared/models/caregiver_form_data.dart';
import 'package:caregiver_hub/shared/models/user_form_data.dart';
import 'package:caregiver_hub/shared/utils/io.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;
  final _geo = getIt<Geoflutterfire>();

  Stream<UserFormData> fetchUserFormData(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .get()
        .asStream()
        .map((snapshot) {
      final docs = snapshot.data() as Map<String, dynamic>;
      return UserFormData(
        id: userId,
        imageURL: docs['imageURL'],
        name: docs['fullName'],
        cpf: docs['cpf'],
        phone: docs['phone'],
        email: docs['email'],
      );
    });
  }

  Stream<CaregiverFormData> fetchCaregiverFormData(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .get()
        .asStream()
        .map((snapshot) {
      final doc = snapshot.data() as Map<String, dynamic>;
      return CaregiverFormData(
        id: userId,
        showAsCaregiver: doc['showAsCaregiver'] ?? false,
        location: Location(
          placeId: doc['location']['placeId'],
          placeDescription: doc['location']['placeDescription'],
          coordinates: LatLng(
            doc['location']['coordinates']['latitude'],
            doc['location']['coordinates']['longitude'],
          ),
          radius: double.parse(doc['location']['radius'].toString()),
        ),
        // location: Location(
        //   placeId: '',
        //   placeDescription: '',
        //   coordinates: LatLng(0, 0),
        //   geoHash: '',
        //   radius: null,
        // ),
        bio: doc['bio'],
        services: ((doc['services'] as List?) ?? [])
            .map(
              (item) => Service(
                id: item['id'],
                description: item['description'],
              ),
            )
            .toList(),
        skills: ((doc['skills'] as List?) ?? [])
            .map(
              (item) => Skill(
                id: item['id'],
                description: item['description'],
              ),
            )
            .toList(),
        startPrice: doc['startPrice'] ?? 0,
        endPrice: doc['endPrice'] ?? 0,
      );
    });
  }

  Future<void> updateUser({
    required String? imagePath,
    required String fullName,
    required String cpf,
    required String phone,
    required String email,
    required String? password,
  }) async {
    return await handleFirebaseExceptions(() async {
      if (_auth.currentUser == null) {
        throw ServiceException(
          'É necessário estar logado para alterar os dados do usuário.',
        );
      }

      if (password != null && password.trim() != '') {
        _auth.currentUser!.updatePassword(password);
      }

      if (imagePath == null || imagePath.trim() == '') {
        final String imageURL =
            await uploadImage(_auth.currentUser!.uid, imagePath!);
        await _firestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .update({
          'fullName': fullName,
          'cpf': cpf,
          'phone': phone,
          'email': email,
          'imageURL': imageURL,
        });
      } else {
        await _firestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .update({
          'fullName': fullName,
          'cpf': cpf,
          'phone': phone,
          'email': email,
        });
      }
    });
  }

  Future<void> updateCaregiverData({
    required String userId,
    required bool showAsCaregiver,
    required Location location,
    required String? bio,
    required List<Service> services,
    required List<Skill> skills,
    required double startPrice,
    required double endPrice,
  }) async {
    return await handleFirebaseExceptions(() async {
      await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
        'showAsCaregiver': showAsCaregiver,
        'location': {
          'placeId': location.placeId,
          'placeDescription': location.placeDescription,
          'coordinates': {
            'latitude': location.coordinates.latitude,
            'longitude': location.coordinates.longitude,
          },
          'radius': location.radius,
        },
        'bio': bio,
        'services': services
            .map(
              (item) => {
                'id': item.id,
                'description': item.description,
              },
            )
            .toList(),
        'skills': skills
            .map(
              (item) => {
                'id': item.id,
                'description': item.description,
              },
            )
            .toList(),
        'startPrice': startPrice,
        'endPrice': endPrice,
      });
    });
  }

  Future<UserCredential> createUser({
    required String? imagePath,
    required String fullName,
    required String cpf,
    required String phone,
    required String email,
    required String password,
  }) async {
    return await handleFirebaseExceptions(() async {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String? imageURL = imagePath == null || imagePath.trim() == ''
          ? null
          : await uploadImage(userCredential.user!.uid, imagePath);

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'fullName': fullName,
        'cpf': cpf,
        'phone': phone,
        'email': email,
        'imageURL': imageURL,
      });

      return userCredential;
    });
  }

  Future<String> uploadImage(String userId, String imagePath) async {
    return await handleFirebaseExceptions(() async {
      final ref = _storage.ref().child('userImage').child(userId + '.jpg');
      return await (await ref.putFile(File(imagePath))).ref.getDownloadURL();
    });
  }

  Stream<JobUserData> fetchJobUserData({required String userId}) {
    return _firestore.collection('users').doc(userId).snapshots().map(
          (snapshot) => JobUserData(
            id: snapshot.id,
            imageURL: snapshot['imageURL'],
            name: snapshot['fullName'],
            phone: snapshot['phone'],
            email: snapshot['email'],
          ),
        );
  }

  Stream<CaregiverRecomendationUserData> fetchCaregiverRecomendationUserData({
    required String userId,
  }) {
    return _firestore.collection('users').doc(userId).get().asStream().map(
          (snapshot) => CaregiverRecomendationUserData(
            imageURL: snapshot['imageURL'],
            name: snapshot['fullName'],
          ),
        );
  }
}
