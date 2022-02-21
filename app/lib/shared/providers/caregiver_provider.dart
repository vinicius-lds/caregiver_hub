import 'package:caregiver_hub/main.dart';
import 'package:caregiver_hub/shared/constants/pagination.dart';
import 'package:caregiver_hub/shared/models/caregiver.dart';
import 'package:caregiver_hub/shared/models/place_coordinates.dart';
import 'package:caregiver_hub/shared/models/service.dart';
import 'package:caregiver_hub/shared/models/skill.dart';
import 'package:caregiver_hub/shared/services/caregiver_service.dart';
import 'package:flutter/foundation.dart';

class CaregiverProvider with ChangeNotifier {
  final CaregiverService _caregiverService = getIt<CaregiverService>();

  PlaceCoordinates? placeCoordinates;
  List<Service>? services;
  List<Skill>? skills;

  Stream<List<Caregiver>> listStream({
    required String idIgnore,
    int size = pageSize,
  }) {
    return _caregiverService.fetchCaregivers(
      idIgnore: idIgnore,
      placeCoordinates: placeCoordinates,
      services: services,
      skills: skills,
      size: size,
    );
  }

  void applyFilter({
    PlaceCoordinates? placeCoordinates,
    List<Service?>? services,
    List<Skill?>? skills,
  }) {
    placeCoordinates = placeCoordinates;
    services = services;
    skills = skills;
  }
}
