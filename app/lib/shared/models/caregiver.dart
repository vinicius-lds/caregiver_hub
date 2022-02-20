import 'package:caregiver_hub/shared/models/service.dart';
import 'package:caregiver_hub/shared/models/skill.dart';

class Caregiver {
  final String id;
  final String name;
  final String? imageURL;
  final String phone;
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
    required this.bio,
    required this.startPrice,
    required this.endPrice,
    required this.rating,
    required this.services,
    required this.skills,
  });
}
