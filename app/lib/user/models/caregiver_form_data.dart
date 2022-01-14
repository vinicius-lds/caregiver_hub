import 'package:caregiver_hub/shared/models/service.dart';
import 'package:caregiver_hub/shared/models/skill.dart';

class CaregiverFormData {
  final String id;
  final bool isActive;
  final String? bio;
  final List<Service> services;
  final List<Skill> skills;
  const CaregiverFormData({
    required this.id,
    required this.isActive,
    required this.bio,
    required this.services,
    required this.skills,
  });
}
