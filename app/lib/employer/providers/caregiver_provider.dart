import 'package:caregiver_hub/employer/models/caregiver.dart';
import 'package:caregiver_hub/employer/models/service_type.dart';
import 'package:caregiver_hub/employer/models/skill_type.dart';
import 'package:flutter/foundation.dart';

class CaregiverProvider with ChangeNotifier {
  final List<Caregiver> _caregivers = _loadMockData();

  Stream<List<Caregiver>> listStream() {
    return Stream.value(_caregivers);
  }

  void applyFilter({
    DateTime? startDate,
    DateTime? endDate,
    List<ServiceType?>? serviceTypes,
    List<SkillType?>? skillTypes,
  }) {
    print('''
    applyFilter
    startDate: $startDate;
    endDate: $endDate;
    serviceTypes: $serviceTypes;
    skillTypes: $skillTypes.
    ''');
  }
}

List<Caregiver> _loadMockData() {
  return [
    const Caregiver(
      id: '1',
      name: 'Giovanna Dias Silva',
      imageURL: 'https://picsum.photos/1920/1080?random=1',
      bio:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      startPriceRange: 1500,
      endPriceRange: 2000,
      rating: 5,
    ),
    const Caregiver(
      id: '2',
      name: 'Bruna Alves Carvalho',
      imageURL: 'https://picsum.photos/1920/1080?random=2',
      bio:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      startPriceRange: 300,
      endPriceRange: 500,
      rating: 3.5,
    ),
    const Caregiver(
      id: '3',
      name: 'Julieta Lima Souza',
      imageURL: 'https://picsum.photos/1920/1080?random=3',
      bio:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      startPriceRange: null,
      endPriceRange: null,
      rating: 4.5,
    ),
    const Caregiver(
      id: '4',
      name: 'Gabriel Barbosa',
      imageURL:
          'https://conteudo.imguol.com.br/c/esporte/f3/2021/11/11/gabigol-comemora-gol-pelo-flamengo-contra-o-bahia-1636671290995_v2_450x337.jpg',
      bio: 'Herói do bi.',
      startPriceRange: 200000000,
      endPriceRange: null,
      rating: 5,
    ),
    const Caregiver(
      id: '5',
      name: 'Julia Carvalho Pinto',
      imageURL: 'https://picsum.photos/1920/1080?random=5',
      bio:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      startPriceRange: null,
      endPriceRange: 800,
      rating: 2,
    ),
    const Caregiver(
      id: '1',
      name: 'Giovanna Dias Silva',
      imageURL: 'https://picsum.photos/1920/1080?random=1',
      bio:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      startPriceRange: 1500,
      endPriceRange: 2000,
      rating: 5,
    ),
    const Caregiver(
      id: '2',
      name: 'Bruna Alves Carvalho',
      imageURL: 'https://picsum.photos/1920/1080?random=2',
      bio:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      startPriceRange: 300,
      endPriceRange: 500,
      rating: 3.5,
    ),
    const Caregiver(
      id: '3',
      name: 'Julieta Lima Souza',
      imageURL: 'https://picsum.photos/1920/1080?random=3',
      bio:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      startPriceRange: null,
      endPriceRange: null,
      rating: 4.5,
    ),
    const Caregiver(
      id: '4',
      name: 'Gabriel Barbosa',
      imageURL:
          'https://conteudo.imguol.com.br/c/esporte/f3/2021/11/11/gabigol-comemora-gol-pelo-flamengo-contra-o-bahia-1636671290995_v2_450x337.jpg',
      bio: 'Herói do bi.',
      startPriceRange: 200000000,
      endPriceRange: null,
      rating: 5,
    ),
    const Caregiver(
      id: '5',
      name: 'Julia Carvalho Pinto',
      imageURL: 'https://picsum.photos/1920/1080?random=5',
      bio:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      startPriceRange: null,
      endPriceRange: 800,
      rating: 2,
    ),
    const Caregiver(
      id: '1',
      name: 'Giovanna Dias Silva',
      imageURL: 'https://picsum.photos/1920/1080?random=1',
      bio:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      startPriceRange: 1500,
      endPriceRange: 2000,
      rating: 5,
    ),
    const Caregiver(
      id: '2',
      name: 'Bruna Alves Carvalho',
      imageURL: 'https://picsum.photos/1920/1080?random=2',
      bio:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      startPriceRange: 300,
      endPriceRange: 500,
      rating: 3.5,
    ),
    const Caregiver(
      id: '3',
      name: 'Julieta Lima Souza',
      imageURL: 'https://picsum.photos/1920/1080?random=3',
      bio:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      startPriceRange: null,
      endPriceRange: null,
      rating: 4.5,
    ),
    const Caregiver(
      id: '4',
      name: 'Gabriel Barbosa',
      imageURL:
          'https://conteudo.imguol.com.br/c/esporte/f3/2021/11/11/gabigol-comemora-gol-pelo-flamengo-contra-o-bahia-1636671290995_v2_450x337.jpg',
      bio: 'Herói do bi.',
      startPriceRange: 200000000,
      endPriceRange: null,
      rating: 5,
    ),
    const Caregiver(
      id: '5',
      name: 'Julia Carvalho Pinto',
      imageURL: 'https://picsum.photos/1920/1080?random=5',
      bio:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      startPriceRange: null,
      endPriceRange: 800,
      rating: 2,
    ),
  ];
}
