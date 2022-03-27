import 'package:caregiver_hub/shared/models/location.dart';
import 'package:caregiver_hub/shared/models/service.dart';
import 'package:caregiver_hub/shared/models/skill.dart';

class CaregiverFormData {
  final String id;
  final bool showAsCaregiver;
  final Location? location;
  final String? bio;
  final List<Service> services;
  final List<Skill> skills;
  final double startPrice;
  final double endPrice;
  const CaregiverFormData({
    required this.id,
    required this.showAsCaregiver,
    required this.location,
    required this.bio,
    required this.services,
    required this.skills,
    required this.startPrice,
    required this.endPrice,
  });
}
