import 'package:caregiver_hub/main.dart';
import 'package:caregiver_hub/shared/constants/pagination.dart';
import 'package:caregiver_hub/shared/models/caregiver.dart';
import 'package:caregiver_hub/shared/models/location.dart';
import 'package:caregiver_hub/shared/models/service.dart';
import 'package:caregiver_hub/shared/models/skill.dart';
import 'package:caregiver_hub/shared/services/caregiver_service.dart';
import 'package:flutter/foundation.dart';

class CaregiverProvider with ChangeNotifier {
  final CaregiverService _caregiverService = getIt<CaregiverService>();

  Location? _location;
  List<Service>? _services;
  List<Skill>? _skills;

  Stream<List<Caregiver>> listStream({
    required String idIgnore,
    int size = pageSize,
  }) {
    return _caregiverService.fetchCaregivers(
      idIgnore: idIgnore,
      location: _location,
      services: _services,
      skills: _skills,
      size: size,
    );
  }

  void applyFilter({
    Location? location,
    List<Service?>? services,
    List<Skill?>? skills,
  }) {
    _location = location;
    _services =
        services?.where((item) => item != null).map((item) => item!).toList();
    _skills =
        skills?.where((item) => item != null).map((item) => item!).toList();
    notifyListeners();
  }

  get location {
    return _location;
  }

  get services {
    return _services;
  }

  get skills {
    return _skills;
  }
}
