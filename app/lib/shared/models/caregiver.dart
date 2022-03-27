import 'package:caregiver_hub/shared/models/service.dart';
import 'package:caregiver_hub/shared/models/skill.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Caregiver {
  final String id;
  final String name;
  final String? imageURL;
  final String phone;
  final String email;
  final String? bio;
  final double? startPrice;
  final double? endPrice;
  final double rating;
  final List<Service> services;
  final List<Skill> skills;

  const Caregiver({
    required this.id,
    required this.name,
    required this.imageURL,
    required this.phone,
    required this.email,
    required this.bio,
    required this.startPrice,
    required this.endPrice,
    required this.rating,
    required this.services,
    required this.skills,
  });

  factory Caregiver.fromDocumentSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final doc = snapshot.data() ?? {};
    return Caregiver(
      id: snapshot.id,
      name: doc['fullName'],
      imageURL: doc['imageURL'],
      phone: doc['phone'],
      email: doc['email'],
      bio: doc['bio'],
      startPrice: doc['startPrice'],
      endPrice: doc['endPrice'],
      rating: doc['rating'] == null ? 0.0 : doc['rating'].toDouble(),
      services: Service.fromServicesFlagMap(
        Map<String, dynamic>.from(doc['services']),
      ),
      skills: Skill.fromSkillsFlagMap(
        Map<String, dynamic>.from(doc['skills']),
      ),
    );
  }
}
