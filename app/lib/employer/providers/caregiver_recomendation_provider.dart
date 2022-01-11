import 'package:caregiver_hub/employer/models/caregiver_recomendation.dart';
import 'package:flutter/cupertino.dart';

class CaregiverRecomendationProvider with ChangeNotifier {
  Stream<List<CaregiverRecomendation>> listStream({
    required String caregiverId,
    int offset = 0,
    int size = 10,
  }) {
    return Stream.value(_loadMockData());
  }

  Stream<int> countStream({
    required String caregiverId,
  }) {
    return Stream.value(6);
  }
}

List<CaregiverRecomendation> _loadMockData() {
  return [
    const CaregiverRecomendation(
      rating: 1,
      employerImageURL: 'https://picsum.photos/1920/1080?random=20',
      employerName: 'Lucielle Cabral Rocha',
      recomendation:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    ),
    const CaregiverRecomendation(
      rating: 5,
      employerImageURL: 'https://picsum.photos/1920/1080?random=21',
      employerName: 'Fátima Alencar Castilho',
      recomendation:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    ),
    const CaregiverRecomendation(
      rating: 5,
      employerImageURL: 'https://picsum.photos/1920/1080?random=22',
      employerName: 'Vânia Pinho Coelho',
      recomendation:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    ),
    const CaregiverRecomendation(
      rating: 4,
      employerImageURL: 'https://picsum.photos/1920/1080?random=23',
      employerName: 'Poliana Ambrósio Meireles',
      recomendation:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    ),
    const CaregiverRecomendation(
      rating: 3,
      employerImageURL: 'https://picsum.photos/1920/1080?random=24',
      employerName: 'Lorena Belluci Fontana',
      recomendation:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    ),
    const CaregiverRecomendation(
      rating: 2,
      employerImageURL: 'https://picsum.photos/1920/1080?random=25',
      employerName: 'Cristiane Aguiar da Costa',
      recomendation:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    ),
  ];
}
