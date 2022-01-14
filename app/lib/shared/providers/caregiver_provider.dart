import 'package:caregiver_hub/shared/models/caregiver.dart';
import 'package:caregiver_hub/shared/models/service.dart';
import 'package:caregiver_hub/shared/models/skill.dart';
import 'package:flutter/foundation.dart';

class CaregiverProvider with ChangeNotifier {
  final List<Caregiver> _caregivers = _loadMockData();

  Stream<List<Caregiver>> listStream({int offset = 0, int size = 15}) {
    return Stream.value(_caregivers);
  }

  Stream<int> count() {
    return Stream.value(16);
  }

  Stream<Caregiver> byId(String id) {
    return Stream.value(_caregivers.firstWhere((element) => element.id == id));
  }

  void applyFilter({
    DateTime? startDate,
    DateTime? endDate,
    List<Service?>? services,
    List<Skill?>? skills,
  }) {
    print('''
    applyFilter
    startDate: $startDate;
    endDate: $endDate;
    serviceTypes: $services;
    skillTypes: $skills.
    ''');
  }
}

List<Caregiver> _loadMockData() {
  return [
    const Caregiver(
      id: '1',
      name: 'Giovanna Dias Silva',
      imageURL: 'https://picsum.photos/1920/1080?random=1',
      phone: '+5547955729869',
      bio:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      startPrice: 1500,
      endPrice: 2000,
      rating: 5,
      skills: [
        Skill(id: '1', description: 'Habilidade 1'),
      ],
      services: [
        Service(id: '1', description: 'Tipo de serviço 1'),
      ],
    ),
    const Caregiver(
      id: '2',
      name: 'Bruna Alves Carvalho',
      imageURL: 'https://picsum.photos/1920/1080?random=2',
      phone: '+5547955729869',
      bio:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      startPrice: 300,
      endPrice: 500,
      rating: 3.5,
      skills: [
        Skill(id: '1', description: 'Habilidade 1'),
        Skill(id: '2', description: 'Habilidade 2'),
      ],
      services: [
        Service(id: '1', description: 'Tipo de serviço 1'),
      ],
    ),
    const Caregiver(
      id: '3',
      name: 'Julieta Lima Souza',
      imageURL: 'https://picsum.photos/1920/1080?random=3',
      phone: '+5547955729869',
      bio:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      startPrice: null,
      endPrice: null,
      rating: 4.5,
      skills: [
        Skill(id: '3', description: 'Habilidade 3'),
      ],
      services: [
        Service(id: '4', description: 'Tipo de serviço 4'),
        Service(id: '5', description: 'Tipo de serviço 5'),
        Service(id: '6', description: 'Tipo de serviço 6'),
      ],
    ),
    const Caregiver(
      id: '4',
      name: 'Gabriel Barbosa',
      imageURL:
          'https://conteudo.imguol.com.br/c/esporte/f3/2021/11/11/gabigol-comemora-gol-pelo-flamengo-contra-o-bahia-1636671290995_v2_450x337.jpg',
      phone: '+5547955729869',
      bio: 'Herói do bi.',
      startPrice: 200000000,
      endPrice: null,
      rating: 5,
      skills: [
        Skill(id: '3', description: 'Habilidade 3'),
        Skill(id: '5', description: 'Habilidade 5'),
        Skill(id: '8', description: 'Habilidade 8'),
      ],
      services: [],
    ),
    const Caregiver(
      id: '5',
      name: 'Julia Carvalho Pinto',
      imageURL: 'https://picsum.photos/1920/1080?random=5',
      phone: '+5547955729869',
      bio:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      startPrice: null,
      endPrice: 800,
      rating: 2,
      skills: [],
      services: [
        Service(id: '1', description: 'Tipo de serviço 1'),
        Service(id: '6', description: 'Tipo de serviço 6'),
        Service(id: '7', description: 'Tipo de serviço 7'),
        Service(id: '10', description: 'Tipo de serviço 10'),
      ],
    ),
    const Caregiver(
      id: '6',
      name: 'Giovanna Dias Silva',
      imageURL: 'https://picsum.photos/1920/1080?random=1',
      phone: '+5547955729869',
      bio:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      startPrice: 1500,
      endPrice: 2000,
      rating: 5,
      skills: [
        Skill(id: '1', description: 'Habilidade 1'),
      ],
      services: [
        Service(id: '1', description: 'Tipo de serviço 1'),
      ],
    ),
    const Caregiver(
      id: '7',
      name: 'Bruna Alves Carvalho',
      imageURL: 'https://picsum.photos/1920/1080?random=2',
      phone: '+5547955729869',
      bio:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      startPrice: 300,
      endPrice: 500,
      rating: 3.5,
      skills: [
        Skill(id: '1', description: 'Habilidade 1'),
        Skill(id: '2', description: 'Habilidade 2'),
      ],
      services: [
        Service(id: '1', description: 'Tipo de serviço 1'),
      ],
    ),
    const Caregiver(
      id: '8',
      name: 'Julieta Lima Souza',
      imageURL: 'https://picsum.photos/1920/1080?random=3',
      phone: '+5547955729869',
      bio:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      startPrice: null,
      endPrice: null,
      rating: 4.5,
      skills: [
        Skill(id: '3', description: 'Habilidade 3'),
      ],
      services: [
        Service(id: '4', description: 'Tipo de serviço 4'),
        Service(id: '5', description: 'Tipo de serviço 5'),
        Service(id: '6', description: 'Tipo de serviço 6'),
      ],
    ),
    const Caregiver(
      id: '9',
      name: 'Gabriel Barbosa',
      imageURL:
          'https://conteudo.imguol.com.br/c/esporte/f3/2021/11/11/gabigol-comemora-gol-pelo-flamengo-contra-o-bahia-1636671290995_v2_450x337.jpg',
      phone: '+5547955729869',
      bio: 'Herói do bi.',
      startPrice: 200000000,
      endPrice: null,
      rating: 5,
      skills: [
        Skill(id: '3', description: 'Habilidade 3'),
        Skill(id: '5', description: 'Habilidade 5'),
        Skill(id: '8', description: 'Habilidade 8'),
      ],
      services: [],
    ),
    const Caregiver(
      id: '10',
      name: 'Julia Carvalho Pinto',
      imageURL: 'https://picsum.photos/1920/1080?random=5',
      phone: '+5547955729869',
      bio:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      startPrice: null,
      endPrice: 800,
      rating: 2,
      skills: [],
      services: [
        Service(id: '1', description: 'Tipo de serviço 1'),
        Service(id: '6', description: 'Tipo de serviço 6'),
        Service(id: '7', description: 'Tipo de serviço 7'),
        Service(id: '10', description: 'Tipo de serviço 10'),
      ],
    ),
    const Caregiver(
      id: '11',
      name: 'Giovanna Dias Silva',
      imageURL: 'https://picsum.photos/1920/1080?random=1',
      phone: '+5547955729869',
      bio:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      startPrice: 1500,
      endPrice: 2000,
      rating: 5,
      skills: [
        Skill(id: '1', description: 'Habilidade 1'),
      ],
      services: [
        Service(id: '1', description: 'Tipo de serviço 1'),
      ],
    ),
    const Caregiver(
      id: '12',
      name: 'Bruna Alves Carvalho',
      imageURL: 'https://picsum.photos/1920/1080?random=2',
      phone: '+5547955729869',
      bio:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      startPrice: 300,
      endPrice: 500,
      rating: 3.5,
      skills: [
        Skill(id: '1', description: 'Habilidade 1'),
        Skill(id: '2', description: 'Habilidade 2'),
      ],
      services: [
        Service(id: '1', description: 'Tipo de serviço 1'),
      ],
    ),
    const Caregiver(
      id: '13',
      name: 'Julieta Lima Souza',
      imageURL: 'https://picsum.photos/1920/1080?random=3',
      phone: '+5547955729869',
      bio:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      startPrice: null,
      endPrice: null,
      rating: 4.5,
      skills: [
        Skill(id: '3', description: 'Habilidade 3'),
      ],
      services: [
        Service(id: '4', description: 'Tipo de serviço 4'),
        Service(id: '5', description: 'Tipo de serviço 5'),
        Service(id: '6', description: 'Tipo de serviço 6'),
      ],
    ),
    const Caregiver(
      id: '14',
      name: 'Gabriel Barbosa',
      imageURL:
          'https://conteudo.imguol.com.br/c/esporte/f3/2021/11/11/gabigol-comemora-gol-pelo-flamengo-contra-o-bahia-1636671290995_v2_450x337.jpg',
      phone: '+5547955729869',
      bio: 'Herói do bi.',
      startPrice: 200000000,
      endPrice: null,
      rating: 5,
      skills: [
        Skill(id: '3', description: 'Habilidade 3'),
        Skill(id: '5', description: 'Habilidade 5'),
        Skill(id: '8', description: 'Habilidade 8'),
      ],
      services: [],
    ),
    const Caregiver(
      id: '15',
      name: 'Julia Carvalho Pinto',
      imageURL: 'https://picsum.photos/1920/1080?random=5',
      phone: '+5547955729869',
      bio:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      startPrice: null,
      endPrice: 800,
      rating: 2,
      skills: [],
      services: [
        Service(id: '1', description: 'Tipo de serviço 1'),
        Service(id: '6', description: 'Tipo de serviço 6'),
        Service(id: '7', description: 'Tipo de serviço 7'),
        Service(id: '10', description: 'Tipo de serviço 10'),
      ],
    ),
  ];
}
