import 'package:caregiver_hub/employer/models/caregiver_recomendation_card_data.dart';
import 'package:caregiver_hub/employer/models/caregiver_recomendation_form_data.dart';
import 'package:flutter/cupertino.dart';

class CaregiverRecomendationProvider with ChangeNotifier {
  Stream<List<CaregiverRecomendationCardData>> cardDataListStream({
    required String caregiverId,
    int offset = 0,
    int size = 10,
  }) {
    return Stream.value(_loadCardDataListMockData());
  }

  Stream<int> countStream({
    required String caregiverId,
  }) {
    return Stream.value(6);
  }

  Stream<CaregiverRecomendationFormData> formDataStream({
    required String caregiverId,
    required String employerId,
  }) {
    return Stream.value(_loadFormDataMockData());
  }
}

CaregiverRecomendationFormData _loadFormDataMockData() {
  return const CaregiverRecomendationFormData(
    id: null,
    caregiverId: '1',
    caregiverName: 'Gabriela Rodrigues Lima',
    caregiverImageURL: 'https://picsum.photos/1920/1080?random=51',
    rating: null,
    recomendation: null,
  );
}

List<CaregiverRecomendationCardData> _loadCardDataListMockData() {
  return [
    const CaregiverRecomendationCardData(
      rating: 1,
      employerImageURL: 'https://picsum.photos/1920/1080?random=20',
      employerName: 'Lucielle Cabral Rocha',
      recomendation:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    ),
    const CaregiverRecomendationCardData(
      rating: 5,
      employerImageURL: 'https://picsum.photos/1920/1080?random=21',
      employerName: 'Fátima Alencar Castilho',
      recomendation:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    ),
    const CaregiverRecomendationCardData(
      rating: 5,
      employerImageURL: 'https://picsum.photos/1920/1080?random=22',
      employerName: 'Vânia Pinho Coelho',
      recomendation:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    ),
    const CaregiverRecomendationCardData(
      rating: 4,
      employerImageURL: 'https://picsum.photos/1920/1080?random=23',
      employerName: 'Poliana Ambrósio Meireles',
      recomendation:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    ),
    const CaregiverRecomendationCardData(
      rating: 3,
      employerImageURL: 'https://picsum.photos/1920/1080?random=24',
      employerName: 'Lorena Belluci Fontana',
      recomendation:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    ),
    const CaregiverRecomendationCardData(
      rating: 2,
      employerImageURL: 'https://picsum.photos/1920/1080?random=25',
      employerName: 'Cristiane Aguiar da Costa',
      recomendation:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    ),
  ];
}
